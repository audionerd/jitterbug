module Jitterbug
  module Config

    @@settings = { :background => 'transparent',
                   :color      => 'black',
                   :font       => '*',
                   :font_dir   => '/lib/fonts/',
                   :format     => 'png',
                   :img_path   => '/content/jitterbug/',
                   :size       => 16 }

    def self.read      
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