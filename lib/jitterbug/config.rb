module Jitterbug
  module Config

    @@settings = { :background => 'transparent',
                   :color      => 'black',
                   :font       => '*',
                   :font_dir   => '/lib/fonts/',
                   :format     => 'png',
                   :kerning    => 0,
                   :img_path   => '/content/jitterbug/',
                   :size       => 16 }

    def self.read      
      # TODO add :leading setting which requires >ImageMagick 6.5.5-8 to use -interline-spacing option
      config = "#{Jitterbug::root}/config/jitterbug.yml"
      if File.exist?(config)
        YAML.load_file(config)[Jitterbug::environment].each {|key, value| @@settings[key.to_sym] = value}
      end
    end
    
    def self.settings
      @@settings
    end

  end
end