module Jitterbug
  module Config

    @@settings = { :background => 'transparent',
                   :color      => 'black',
                   :font       => '*',
                   :font_dir   => '/lib/fonts/',
                   :format     => 'png',
                   :kerning    => 0,
                   :img_path   => '/content/jitterbug/',
                   :size       => 24 }

    def self.read      
      # TODO add :leading setting which requires >ImageMagick 6.5.5-8 to use -interline-spacing option
      config = "#{Jitterbug::Config.root}/config/jitterbug.yml"
      if File.exist?(config)
        YAML.load_file(config)[Jitterbug::Config.env].each {|key, value| @@settings[key.to_sym] = value}
      end
    end
    
    def self.settings
      @@settings
    end
    
    # accessor methods, with defaults for Rails
    def self.root
      @@root ||= RAILS_ROOT
    end
    
    def self.root=(value)
      @@root = value
    end
    
    def self.env
      @@environment ||= RAILS_ENV
    end
    
    def self.env=(value)
      @@environment = value
    end

  end
end