module Jitterbug
  module Html

    def self.img(src, opts = {})
      tag(:img, nil, opts.reverse_merge(:src => src))
    end

    def self.tag(type, content, opts = {})
      attrs = opts.collect { |key, val| val.blank? ? nil : "#{key}=\"#{val}\"" }.compact.join(' ')
      base  = (attrs.present? ? "<#{name} #{attrs}" : "<#{name}")
      base << (content ? ">#{content}</#{name}>" : " />")
    end

  end
end