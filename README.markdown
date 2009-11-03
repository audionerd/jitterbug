# Jitterbug: A just-in-time image creator for pretty text headers

Jitterbug provides on-demand text header images using the font of your choice. On the first request, Jitterbug creates the requested header graphic and returns its image tag. On subsequent requests it returns the image tag of the already-created graphic.

## Usage

Pass the `jitterbug` helper a string to convert into a header graphic. Optionally pass in any other parameters that differ from the defaults.

    <%= jitterbug 'Default' %>
    <%= jitterbug('News', :size => 24) %>
    <%= jitterbug(t('whole_enchilada'), :background => '#fff', :color => 'green', :font => 'Yummy.otf', :font_dir => '/fonts/', :format => 'gif', :img_path => '/images/headers/', :size => 64) %>

## Dependencies

Jitterbug uses `Imagemagick` to build the header images. It needs to be installed on your development and production machines, as do any fonts that you're using.

## Quick Links

 * [github.com/flyingsaucer/jitterbug](http://github.com/flyingsaucer/jitterbug)
 * [imagemagick.org](http://www.imagemagick.org/script/index.php)

## Installation

    sudo gem install jitterbug

In your `config/environment.rb` file:

    Rails::Initializer.run do |config|
      config.gem "jitterbug", :source  => 'http://gemcutter.org/'
    end

## Configuration

Define your global configuration in `config/jitterbug.yml`. The following sample contains Jitterbug's built in defaults. Note that the asterisk default for the font causes Jitterbug to use the first font that it finds in the font_dir folder.

    development:   &defaults
      background:  transparent
      color:       white
      font:        *
      font_dir:    /lib/fonts/
      format:      png
      img_path:    /content/jitterbug/
      size:        14

    test:
      <<:          *defaults
      img_path:    /tmp/jitterbug/

    production:
      <<:          *defaults