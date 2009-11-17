module Jitterbug
  module Html

    def self.img(src, opts = {})
      tag(:img, nil, opts.merge(:src => src))
    end

    def self.tag(type, content, opts = {})
      attrs = opts.collect { |key, val| val.blank? ? nil : "#{key}=\"#{val}\"" }.compact.join(' ')
      base  = (attrs.present? ? "<#{type} #{attrs}" : "<#{type}")
      base << (content ? ">#{content}</#{type}>" : " />")
    end

  end
end