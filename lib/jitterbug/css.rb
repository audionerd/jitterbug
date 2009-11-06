module Jitterbug
  module Css

    def self.fat(src, options)
      css = "display:block;text-indent:-9999px;margin:0;padding:0;background:url(#{src})no-repeat;"
      styles(css, options)
    end

    def self.tag(src, options)
      css = "background-image:url(#{src});"
      styles(css, options)
    end

    def self.styles(css, options)
      css += "height:#{options[:size]}px;" if options[:width].nil?
      "#{css}#{options[:css].to_s}"
    end
  end
end