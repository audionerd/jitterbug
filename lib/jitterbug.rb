require 'jitterbug/config'
require 'jitterbug/css'
require 'jitterbug/fonts'
require 'md5'

module Jitterbug
  
  def self.included(base)
    Jitterbug::Config.read
  end

  def jitterbug(label = '<jitterbug>', options = {})
    options = Jitterbug::Config.settings.merge(options)
    hash = MD5.new("#{label}#{options.sort {|a, b| a[0].to_s <=> b[0].to_s}.to_s}")
    path = "#{RAILS_ROOT}/public/#{options[:img_path]}/#{hash}.#{options[:format]}".gsub('//', '/')
    unless File.exist?(path)
      caption = options[:width] ? "-size #{options[:width]}x caption:'#{label}'" : "label:'#{label}'"
      `mkdir -p #{"#{RAILS_ROOT}/public/#{options[:img_path]}".gsub('//', '/')}`
      `convert -background #{options[:background]} -fill "#{options[:color]}" \
        -font #{Jitterbug::Fonts.find(options[:font_dir], options[:font])} \
        -kerning #{options[:kerning]} \
        -pointsize #{options[:size]} -blur 0x.3 #{caption} #{path}`
    end
    img_src   = "/#{options[:img_path]}/#{hash}.#{options[:format]}".gsub('//', '/')
    img_class = (['jitterbug'] << options[:class]).compact.join(' ')
    if options[:tag]
      content_tag(options[:tag], label, :class => img_class, :style => Jitterbug::Css.tag(img_src, options))
    elsif options[:fat]
      content_tag(options[:fat], label, :class => img_class, :style => Jitterbug::Css.fat(img_src, options))
    else
      image_tag(img_src, :alt => label, :class => img_class)
    end
  end

end