require "jekyll-assets"

module Testing
  def awesome input
    "This is awesome"
  end
end

Liquid::Template.register_filter Testing
