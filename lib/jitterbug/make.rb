require 'md5'

module Jitterbug
  module Make

    def self.header(label, options)
      hash  = MD5.new("#{label}#{options.sort {|a, b| a[0].to_s <=> b[0].to_s}.to_s}")
      image = "/#{options[:img_path]}/#{hash}.#{options[:format]}".gsub('//', '/')
      path  = "#{options[:root]}/public/#{image}".gsub('//', '/')

      if !File.exist?(path)
        caption = options[:width] ? "-size #{options[:width]}x caption:'#{label}'" :
                                    "label:'#{label}'"
        FileUtils.mkdir_p("#{options[:root]}/public/#{options[:img_path]}".gsub('//', '/'))
        `convert -background #{options[:background]} -fill "#{options[:color]}" \
          -font #{find_font(options)} -pointsize #{options[:size]} -blur 0x.3 \
          #{caption} #{path}`
        # TODO -kerning #{options[:kerning]} TODO add leading and kerning
      end
      image
    end
    
    def self.find_font(options)
      path = "#{options[:root]}/#{options[:font_dir]}/*#{options[:font]}*".gsub('//', '/')
      font = Dir.glob(path)
      case font.size
        when 0: raise "*** Jitterbug Error: Font '#{options[:font]}' could not be found in #{options[:font_dir]}"
        when 1: return font.first
        else    raise "*** Jitterbug Error: Multiple fonts matched '#{options[:font]}' in #{options[:font_dir]}:\n    + #{font.join("\n    + ")}"
      end
    end

  end
end