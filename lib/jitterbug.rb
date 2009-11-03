require 'jitterbug/config'
require 'jitterbug/fonts'
require 'md5'

module Jitterbug
  
  def self.included(base)
    Jitterbug::Config.read
  end

  def jitterbug(label = '<no label provided>', options = {})
    options = Jitterbug::Config.settings.merge(options)
    hash = MD5.new("#{label}#{options.sort {|a, b| a[0].to_s <=> b[0].to_s}.to_s}")
    path = "#{RAILS_ROOT}/public/#{options[:img_path]}/#{hash}.#{options[:format]}".gsub('//', '/')
    unless File.exist?(path)
      caption = options[:width] ? "-size #{options[:width]}x caption:'#{label}'" : "label:'#{label}'"
      `mkdir -p #{"#{RAILS_ROOT}/public/#{options[:img_path]}".gsub('//', '/')}`
      `convert -background #{options[:background]} -fill "#{options[:color]}" \
        -font #{Jitterbug::Fonts.find(options[:font_dir], options[:font])} \
        -pointsize #{options[:size]} -blur 0x.3 #{caption} #{path}`
    end
    image_tag "/#{options[:img_path]}/#{hash}.#{options[:format]}".gsub('//', '/'),
              :class => (['jitterbug'] << options[:class]).compact.join(' '),
              :alt => label
  end

end