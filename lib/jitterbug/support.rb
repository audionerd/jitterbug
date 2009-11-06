module Jitterbug
  module Support
    
    def self.fonts(_path, _font)
      path = "#{RAILS_ROOT}/#{_path}/*#{_font}*".gsub('//', '/')
      font = Dir.glob(path)
      case font.size
        when 0: raise "*** Jitterbug Error: Font '#{_font}' could not be found in #{_path}"
        when 1: return font.first
        else    raise "*** Jitterbug Error: Multiple fonts matched '#{_font}' in #{_path}:\n    + #{font.join("\n    + ")}"
      end
    end
    
    def self.styles(path, minimal)
      if minimal
        "background-image: url(#{img_src});"
      else
        "display: block; text-indent: -9999px; margin: 0; padding: 0; background: url(#{img_src}) no-repeat;"
      end
    end
    
  end
end