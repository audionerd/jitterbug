module Jitterbug
  module Html

    def render(src, label, opts = {})
      img_class = (['jitterbug'] << opts[:class]).compact.join(' ')
      if opts[:tag]
        tag(opts[:tag], label, :class => img_class, :style => skinny_styles(img_src, opts))
      elsif opts[:fat]
        tag(opts[:fat], label, :class => img_class, :style => fat_styles(img_src, opts))
      else
        tag(:img, nil, :src => img_src, :alt => label, :class => img_class, :style => opts[:style])
      end
    end

    def self.tag(type, content, opts)
      attrs = opts.collect { |key, val| val.blank? ? nil : "#{key}=\"#{val}\"" }.compact.join(' ')
      base  = (attrs.present? ? "<#{type} #{attrs}" : "<#{type}")
      base << (content ? ">#{content}</#{type}>" : " />")
    end
    
    def self.fat_styles(src, opts)
      css = "display:block;text-indent:-9999px;margin:0;padding:0;background:url(#{src})no-repeat;"
      css += "height:#{opts[:size]}px;" if opts[:width].nil?
      "#{css}#{opts[:style].to_s}"
    end

    def self.skinny_styles(src, opts)
      "background-image:url(#{src});#{opts[:style].to_s}"
    end

  end
end