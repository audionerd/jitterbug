module Jitterbug
  module Config

    @@settings = { :background => 'transparent',
                   :color      => 'black',
                   :font       => '*',
                   :font_dir   => '/lib/fonts/',
                   :format     => 'png',
                   :kerning    => 0,
                   :img_path   => '/content/jitterbug/',
                   :size       => 24,
                   :remember   => :memory,
                   :root       => RAILS_ROOT,
                   :env        => RAILS_ENV }

                   # TODO add :leading setting which requires >ImageMagick 6.5.5-8 to use -interline-spacing option

    def self.read
      config = File.join(@@settings[:root], 'config', 'jitterbug.yml')
      if File.exist?(config)
        YAML.load_file(config)[Jitterbug::Config.env].each {|key, value| @@settings[key.to_sym] = value}
      end
    end
    
    def self.settings
      @@settings
    end
    
    def self.root=(val)
      @@settings[:root] = val
    end
    
    def self.env=(val)
      @@settings[:env] = val
    end

  end
end