module Jitterbug
  module Fonts
    
    def self.find(_path, _font)
      path = "#{Jitterbug::Config.root}/#{_path}/*#{_font}*".gsub('//', '/')
      font = Dir.glob(path)
      case font.size
        when 0: raise "*** Jitterbug Error: Font '#{_font}' could not be found in #{_path}"
        when 1: return font.first
        else    raise "*** Jitterbug Error: Multiple fonts matched '#{_font}' in #{_path}:\n    + #{font.join("\n    + ")}"
      end
    end

  end
end