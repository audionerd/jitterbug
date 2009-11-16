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

    # TODO add :leading setting which requires >ImageMagick 6.5.5-8 to use -interline-spacing option

    def self.read
      config = "#{RAILS_ROOT}/config/jitterbug.yml"
      if File.exist?(config)
        YAML.load_file(config)[RAILS_ENV].each {|key, value| @@settings[key.to_sym] = value}
      end
    end
    
    def self.settings
      @@settings
    end
    
  end
end