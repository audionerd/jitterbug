require 'md5'

module Jitterbug
  module Make

    @@memory ||= []
    
    def self.header(label, options)
      hash   = MD5.new("#{label}#{options.sort {|a, b| a[0].to_s <=> b[0].to_s}.to_s}")
      image  = "/#{options[:img_path]}/#{hash}.#{options[:format]}".gsub('//', '/')
      path   = "#{options[:root]}/public/#{image}".gsub('//', '/')
      exists = options[:remember] == :memory ? @@memory.inlude?(hash) :
                                               File.exist?(path)
      if !exists
        caption = options[:width] ? "-size #{options[:width]}x caption:'#{label}'" :
                                    "label:'#{label}'"
        FileUtils.mkdir_p("#{options[:root]}/public/#{options[:img_path]}".gsub('//', '/'))
        `convert -background #{options[:background]} -fill "#{options[:color]}" \
          -font #{find_font(options)} -pointsize #{options[:size]} -blur 0x.3 \
          #{caption} #{path}`
        # TODO -kerning #{options[:kerning]} TODO add leading and kerning
        @@memory << hash if options[:remember] == :memory
      end
      image
    end
    
    def self.find_font(options)
      path = "#{options[:root]}/#{options[:font_dir]}/*#{options[:font]}*".gsub('//', '/')
      font = Dir.glob(path)
      case font.size
        when 0: raise "*** Jitterbug Error: Font '#{_font}' could not be found in #{_path}"
        when 1: return font.first
        else    raise "*** Jitterbug Error: Multiple fonts matched '#{_font}' in #{_path}:\n    + #{font.join("\n    + ")}"
      end
    end

  end
end