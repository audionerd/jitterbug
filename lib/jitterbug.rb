require 'jitterbug/config'
require 'jitterbug/support'
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
        -font #{Jitterbug::Support.fonts(options[:font_dir], options[:font])} \
        -pointsize #{options[:size]} -blur 0x.3 #{caption} #{path}`
    end
    img_src   = "/#{options[:img_path]}/#{hash}.#{options[:format]}".gsub('//', '/')
    img_class = (['jitterbug'] << options[:class]).compact.join(' ')
    if options[:tag].nil? || options[:tag].to_s.downcase == 'img'
      image_tag(img_src, :alt => label, :class => img_class)
    else
      content_tag(options[:tag], label, :class => img_class, :style => Jitterbug::Support.styles(img_src, options[:min]))
    end
  end

end