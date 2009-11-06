# Jitterbug: A just-in-time image creator for pretty text headers

Jitterbug provides on-demand graphical text headers using the font of your choice. On the first request, Jitterbug creates the requested header graphic and returns its image tag. On subsequent requests it returns the image tag of the already-created graphic.

## Usage

    jitterbug(label, options = {})
    
Pass the `jitterbug` helper a string to convert into a header graphic. Optionally pass in any other parameters that differ from the defaults.

    jitterbug 'Hello World'
    => <img alt="Hello World" class="jitterbug" src="/content/jitterbug/69e3dda2fea30a43a11b960e7e9d9980.png?1257526589" />

    jitterbug t('hello_world')
    => <img alt="Hello World" class="jitterbug" src="/content/jitterbug/69e3dda2fea30a43a11b960e7e9d9980.png?1257526589" />

    jitterbug 'Hello World', :size => 42
    => <img alt="Hello World" class="jitterbug" src="/content/jitterbug/b07af9665275babd5632c5a5fa998a13.png?1257526682" />

    jitterbug 'Hello World', :tag => :h1, :width => 240
    => <h1 class="jitterbug" style="background-image:url(/content/jitterbug/7516ee65a817658e4fc5a87b13b0e5c8.png);">Hello World</h1>

    jitterbug 'Hello World', :fat => :h2, :format => :gif
    => <h2 class="jitterbug" style="display:block;text-indent:-9999px;margin:0;padding:0;background:url(/content/jitterbug/99d3a5d5e513074f2e8835bd34f82b9f.gif)no-repeat;height:16px;">Hello World</h2>

## Installation

Install the gem:

    sudo gem install jitterbug

In your `config/environment.rb` file:

    Rails::Initializer.run do |config|
      ...
      config.gem "jitterbug", :source  => 'http://gemcutter.org/'
      ...
    end

In your `app\controllers\application_controller.rb` file:

    class ApplicationController < ActionController::Base
      ...
      helper Jitterbug
      ...
    end

Drop any fonts into your project's font directory (by default `/lib/fonts`).
    
## Available Options

`:background` Background color for the generated header image (default `transparent`)

`:class` Any additional classes to include in the generated tag (default `jitterbug`)

`:color` Font color for the generated header image (default `black`)

`:fat` Return the specified tag (eg. `:fat => :h1`) with full inline styles to hide a text label and show the graphic instead (see the next section)

`:font_dir` Directory where fonts reside (default `/lib/fonts/`)

`:font` Font to use in the generated header image (default `*`, ie. first font found in the font directory)

`:format` Format to output the generated header image (default `png`)

`:img_path` Image path for generated header images (default `/content/jitterbug/`)

`:size` Font size for the generated header image (default `16`)

`:style` Any additional inline styles to include in the generated tag

`:tag` Return the specified tag (eg. `:tag => :h1`) with only the `background-image` declared inline (see the next section)

`:width` Maximum width for the generated header image (text will wrap to a new line to stay within the specified width)

## Using the `:fat` and `:tag` Options

Jitterbug provides two easy ways to display a header graphic within HTML header tags. The first and simplest is by passing `:fat => :h1` in with the options (replacing `:h1` with whatever tag you need). For example:

    <%= jitterbug 'Hello World', :size => 64, :fat => :h2 %>

generates the following HTML with all the necessary styles defined inline:

    <h2 class="jitterbug" style="display:block;text-indent:-9999px;margin:0;padding:0;background:url(/content/jitterbug/a034939a8aaccd59354207b4fdff120b.png)no-repeat;height:64px;">Hello World</h2>

The alternative option is `:tag => :h1`, which generates a leaner tag:

    <h1 class="jitterbug" style="background-image:url(/content/jitterbug/37cf820f2f6b018f6f4d486517ac8d20.png);">Hello World</h1>
    
Which relies on an external stylesheet like the following:

    h1.jitterbug {
      background-repeat: no-repeat;
      display: block;
      height: 64px;
      margin: 0;
      padding: 0;
      text-indent: -9999px;
    }

## Dependencies

Jitterbug uses `Imagemagick` to build the header images. It needs to be installed on your development and production machines, as do any fonts that you're using. The default location for fonts is `/lib/fonts` in your project.

Jitterbug currently has several Rails dependencies (`RAILS_ROOT`, `content_tag`, `image_tag`), which aren't completely necessary, but we haven't had a need to remove them yet.

## Quick Links

 * [github.com/flyingsaucer/jitterbug](http://github.com/flyingsaucer/jitterbug)
 * [imagemagick.org](http://www.imagemagick.org/script/index.php)

## Global Configuration

Define your global configuration in `config/jitterbug.yml`. The following sample contains Jitterbug's built in defaults. Note that the asterisk default for the font causes Jitterbug to use the first font that it finds in the font_dir folder.

    development:   &defaults
      background:  transparent
      color:       black
      font:        *
      font_dir:    /lib/fonts/
      format:      png
      img_path:    /content/jitterbug/
      size:        16

    test:
      <<:          *defaults
      img_path:    /tmp/jitterbug/

    production:
      <<:          *defaults