module Jitterbug
  module Css

    def self.fat(src, opts)
      css = "display:block;text-indent:-9999px;margin:0;padding:0;background:url(#{src})no-repeat;"
      css += "height:#{opts[:size]}px;" if opts[:width].nil?
      "#{css}#{opts[:style].to_s}"
    end

    def self.tag(src, opts)
      "background-image:url(#{src});#{opts[:style].to_s}"
    end

  end
end