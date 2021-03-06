# Jitterbug: A just-in-time image creator for pretty text headers

[Jitterbug](http://github.com/flyingsaucer/jitterbug) is a gem that provides on-demand graphical text headers using the font of your choice. Use wherever large collections of rich text headers are necessary — especially useful in i18n projects.

On the initial request, Jitterbug creates the specified header graphic and returns its image or header tag. On subsequent requests it references the already-created graphic and returns the requested valid xhtml tag.

## Usage

    jitterbug(label, options = {})
    
Pass the `jitterbug` helper a string to convert into a header graphic. Optionally pass in any other parameters that differ from the defaults.

    jitterbug 'Hello World'
    => <img alt="Hello World" class="jitterbug" src="/content/jitterbug/72a65768cdccea18870b0cb2bdff4703.png?1258050948" />

![Hello World](http://a51.flying-saucer.net/jitterbug/72a65768cdccea18870b0cb2bdff4703.png)

    jitterbug t('hello_world')
    => <img alt="¡Hola, mundo!" class="jitterbug" src="/content/jitterbug/3a395edcea566b56ed20f6c7b96aeec9.png?1258050948" />

![¡Hola, mundo!](http://a51.flying-saucer.net/jitterbug/3a395edcea566b56ed20f6c7b96aeec9.png)

    jitterbug 'Hello Big World', :size => 72
    => <img alt="Hello Big World" class="jitterbug" src="/content/jitterbug/2dd5f6f98139fcdf3e671eca84671baf.png?1258050948" />

![Hello Big World](http://a51.flying-saucer.net/jitterbug/2dd5f6f98139fcdf3e671eca84671baf.png)

    jitterbug 'Well hello, World, how do you do?', :tag => :h1, :width => 240, :style => 'height: 110px;'
    => <h1 class="jitterbug" style="background-image:url(/content/jitterbug/e0eb0490fcf15de125eaca6cbdffee12.png);height: 110px;">Well hello, World, how do you do?</h1>


![Well hello, World, how do you do?](http://a51.flying-saucer.net/jitterbug/e0eb0490fcf15de125eaca6cbdffee12.png)

    jitterbug 'Hello_World.gif', :fat => :h2, :format => :gif, :color => '#FFCC00', :background => 'black'
    => <h2 class="jitterbug" style="display:block;text-indent:-9999px;margin:0;padding:0;background:url(/content/jitterbug/11686362655ca2fb3235b23a6d6c2621.gif)no-repeat;height:36px;">Hello_World.gif</h2>

![Hello_World.gif](http://a51.flying-saucer.net/jitterbug/11686362655ca2fb3235b23a6d6c2621.gif)

## Installation

Install the gem:

    gem install jitterbug

Drop any fonts into your project's font directory (by default `/lib/fonts`).

### Rails 2:

In your `config/environment.rb` file:

    Rails::Initializer.run do |config|
      ...
      config.gem "jitterbug"
      ...
    end

In your `app\controllers\application_controller.rb` file:

    class ApplicationController < ActionController::Base
      ...
      helper Jitterbug
      ...
    end

### Sinatra:

    require 'sinatra'
    require 'jitterbug'
    
    Jitterbug::Config.root = File.dirname(__FILE__)
    Jitterbug::Config.env  = Sinatra::Application::environment.to_s

    helpers do
      include Jitterbug
    end
    
`Jitterbug::Config.root` is the root path, which should include folders like `public/`, `lib/` and `config/`.

`Jitterbug::Config.env` is the a string representing the current environment (e.g.: `"development"` or `"production"`).

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

The alternative option is `:tag => :h1`:

    <%= jitterbug 'Hello World', :tag => :h1, :width => 240 %>

Which generates a leaner tag:

    <h1 class="jitterbug" style="background-image:url(/content/jitterbug/37cf820f2f6b018f6f4d486517ac8d20.png);">Hello World</h1>
    
And relies on an external stylesheet like the following:

    h1.jitterbug {
      background-repeat: no-repeat;
      display: block;
      height: 64px;
      margin: 0;
      padding: 0;
      text-indent: -9999px;
    }

## Global Configuration

You can optionally define a global configuration in `config/jitterbug.yml`. The following sample mirrors Jitterbug's built in defaults. Note that the asterisk default for the font causes Jitterbug to use the first font that it finds in the font_dir folder.

Jitterbug 0.6.0 uses a new configuration format, breaking compatibility with older versions. The initial root-level block defines the default values. You can include tag-specific cascading definitions. In the config below, `H1` tags are 24pt black text, `H2` tags are 16pt black text in the DinMedium font, and `H2` tags with class `small` specified are 8pt red text in the DinMedium font.

    # Defaults
    background: transparent
    color:      '#000000'
    font:       *
    font_dir:   /lib/fonts/
    format:     png
    img_path:   /content/jitterbug/
    size:       24

    # Tag-Specific
    h2:
      font:     DinMedium
      size:     16
                
    h2.small:
      color:    red
      size:     8
      
## Dependencies

Jitterbug uses [Imagemagick](http://www.imagemagick.org/script/index.php) to build the header images. It needs to be installed on your development and production machines, as do any fonts that you're using. The default location for fonts is `/lib/fonts` in your project.

## Compatibility and Font Types

Jitterbug has been tested on OSX and Linux.

The following font formats have successfully passed through the Jitterbug: OpenType (PostScript flavored), OpenType (TrueType flavored), PostScript (Type1), TrueType (Mac), and TrueType (PC). When processing Postscript fonts, Jitterbug (or rather Imagemagick) only uses the font outline file. Note that you should remove any spaces from your font filenames.

If you're using older Mac PostScript fonts you'll need to copy the font definitions from the resource fork to the data fork (see [here](http://wiki.github.com/sorccu/cufon/trouble-with-font-files) for more information). In OSX you'd do this:

    cat "FontName/..namedfork/rsrc" > "FontName.dfont"

## Contributors

Many thanks to the following contributors:

* Sinatra compatibility by [audionerd](http://github.com/audionerd)
* Apostrophe fix by [Neal White](http://www.cohesivecc.com/)

Jitterbug is written and maintained by [Flying Saucer](http://flying-saucer.net/)