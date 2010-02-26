require 'md5'

module Jitterbug
  
  def self.included(base)
    Config.read_yaml
  end

  def jitterbug(label = '<jitterbug>', options = {})
    opts  = Config.settings(options)
    image = Make.header(label, opts)
    Html.render(image, label, opts)
  end

  module Config

    @@settings = { :background => 'transparent',
                   :color      => 'black',
                   :font       => '*',
                   :font_dir   => '/lib/fonts/',
                   :format     => 'png',
                   :img_path   => '/content/jitterbug/',
                   :size       => 24,
                   :root       => RAILS_ROOT,
                   :env        => RAILS_ENV }

    # TODO add :leading setting which requires >ImageMagick 6.5.5-8 to use -interline-spacing option
    # TODO add :kerning setting

    def self.read_yaml
      config = File.join(@@settings[:root], 'config', 'jitterbug.yml')
      if File.exist?(config)
        YAML.load_file(config).each {|key, value| @@settings[key.to_sym] = value}
      end
    end
    
    def self.settings(opts)
      @@settings.merge(smash(opts[:tag])).
                 merge(smash("#{opts[:tag]}.#{opts[:class]}".to_sym)).
                 merge(opts)
    end

    def self.smash(sub)
      if @@settings[sub].nil?
        {}
      else
        @@settings[sub].inject({}) do |opts, (key, value)|
          opts[(key.to_sym rescue key) || key] = value
          opts
        end
      end
    end

    def self.root=(val)
      @@settings[:root] = val
    end
    
    def self.env=(val)
      @@settings[:env] = val
    end
  end

  module Html

    def self.render(img_src, label, opts = {})
      img_class = (['jitterbug'] << opts[:class]).compact.join(' ')
      if opts[:tag]
        tag(opts[:tag], label, :class => img_class, :style => skinny_styles(img_src, opts))
      elsif opts[:fat]
        tag(opts[:fat], label, :class => img_class, :style => fat_styles(img_src, opts))
      else
        tag(:img, nil, :src => img_src, :alt => label, :class => img_class, :style => opts[:style])
      end
    end

    def self.tag(type, content, opts)
      attrs = opts.collect { |key, val| val.blank? ? nil : "#{key}=\"#{val}\"" }.compact.join(' ')
      base  = (attrs.present? ? "<#{type} #{attrs}" : "<#{type}")
      base << (content ? ">#{content}</#{type}>" : " />")
    end
    
    def self.fat_styles(src, opts)
      css = "display:block;text-indent:-9999px;margin:0;padding:0;background:url(#{src})no-repeat;"
      css += "height:#{opts[:size]}px;" if opts[:width].nil?
      "#{css}#{opts[:style].to_s}"
    end

    def self.skinny_styles(src, opts)
      "background-image:url(#{src});#{opts[:style].to_s}"
    end
  end

  module Make

    def self.header(label, opts)
      hash  = MD5.new("#{label}#{opts.sort {|a, b| a[0].to_s <=> b[0].to_s}.to_s}")
      image = "/#{opts[:img_path]}/#{hash}.#{opts[:format]}".gsub('//', '/')
      path  = "#{opts[:root]}/public/#{image}".gsub('//', '/')

      if !File.exist?(path)
        label.gsub!(/'/, "'\\\\\''")
        caption = opts[:width] ? "-size #{opts[:width]}x caption:'#{label}'" : "label:'#{label}'"
        FileUtils.mkdir_p("#{opts[:root]}/public/#{opts[:img_path]}".gsub('//', '/'))
        `convert -background #{opts[:background]} -fill "#{opts[:color]}" \
          -font #{find_font(opts)} -pointsize #{opts[:size]} -blur 0x.3 \
          #{caption} #{path}`
      end
      image
    end
    
    def self.find_font(opts)
      path = "#{opts[:root]}/#{opts[:font_dir]}/*#{opts[:font]}*".gsub('//', '/')
      font = Dir.glob(path)
      case font.size
        when 0: raise "*** Jitterbug Error: Font '#{opts[:font]}' could not be found in #{opts[:font_dir]}"
        when 1: return font.first
        else    raise "*** Jitterbug Error: Multiple fonts matched '#{opts[:font]}' in #{opts[:font_dir]}:\n    + #{font.join("\n    + ")}"
      end
    end
  end

end