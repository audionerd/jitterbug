%w(config html make).each do |conf|
  require File.expand_path(File.join(File.dirname(__FILE__), 'jitterbug', conf))
end

module Jitterbug
  
  def self.included(base)
    Jitterbug::Config.read
  end

  def jitterbug(label = '<jitterbug>', options = {})
    options = Jitterbug::Config.settings.merge(options)
    image   = Jitterbug::Make.header(label, options)
    Jitterbug::Html.render(image, label, options)
  end

end