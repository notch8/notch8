---
layout: main
title: Services
---
# Welcome to the download page for the MadRailers "Newbie" night.
Here you'll find a VMWare image to download and run in order to get
everyone on the same page and up and running quickly.

## Download VMWare

[OS X](http://downloads.vmware.com/d/info/desktop_downloads/vmware_fusion_for_the_mac/3_0)

[Linux](http://downloads.vmware.com/d/info/desktop_downloads/vmware_player/3_0)

[Windows](http://downloads.vmware.com/d/info/desktop_downloads/vmware_player/3_0)

## Download the image

[Ubuntu.zip](https://s3.amazonaws.com/UbuntuImage/Ubuntu.zip)

MD5 (Ubuntu.zip) = 5adfdbfac4240ef78c73273e6d9ad495

Go do something else for a while... it a big file.

## Instuctions

Open the VM and then log in with the password "letslearn". Once the VM boots please open Terminal (its on the desktop).  When you
open the terminal it will ask for a new password and then ask for an SSH passphrase (leave that blank).  Once that is done, do the following:

{% highlight bash %}
    $ cd work

    $ rails new tutor -T -m rails3_template.rb

    $ cd tutor

    $ rake db:create

    $ ./script/rails g scaffold Page title:string body:text
{% endhighlight %}

edit route file:

  _uncomment root :to => "pages#index"_

{% highlight bash %}
    $ rake db:migrate

    $ ./script/rails s
{% endhighlight %}

Here is the code from the template.

{% highlight ruby %}

# An application template for Rails 3
gem "factory_girl_rails",     :group => [:development, :test]
gem "factory_girl_generator", :group => [:development, :test]
gem "rspec",                  :group => [:development, :test]
gem "rspec-rails",            :group => [:development, :test]
gem "haml"
gem "haml-rails"
gem "taps"
gem "heroku",                 :group => :development

begin
  require 'bundler'
rescue Bundler::GemNotFound => e
  STDERR.puts e.message
  exit!
end

run 'bundle install'

run 'rails g rspec:install'

generators = <<-GENERATORS

    config.generators do |g|
      g.test_framework :rspec, :fixture => true, :views => false
      g.integration_tool :rspec, :fixture => true, :views => true
      g.template_engine :haml
      g.fixture_replacement :factory_girl
    end
GENERATORS

application generators

# describing of layout application
layout = <<-LAYOUT
!!!
%html
  %head
    %title= h(yield(:title) || "Untitled")
    = stylesheet_link_tag :all
    = javascript_include_tag :defaults
    = csrf_meta_tag

    = yield(:head)
  %body
    #container
      - flash.each do |name, msg|
        = content_tag :div, msg, :id => "flash_\#\{name\}", :class => 'flash'
      %nav
        = link_to "Home", root_url
      %header
        - if show_title?
          %h1=h yield(:title)
      %article
        = yield
      %footer

LAYOUT

# ... and a layout helper
layout_helper = <<-LAYOUTHELPER
# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title, show_title = true)
    content_for(:title) { page_title.to_s }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end

end
LAYOUTHELPER

# adding correct routes
new_routes = <<-ROUTES
  #root :to => 'pages#index'
ROUTES

# ... inject there
inject_into_file "config/routes.rb", "\n#{new_routes}", :after => "#{app_name.classify}::Application.routes.draw do"


# removing unused files
remove_file "README"
remove_file "public/index.html"
remove_file "public/images/rails.png"
remove_file "app/views/layouts/application.html.erb"

# creating the new ones
create_file 'README'
create_file "app/views/layouts/application.html.haml", layout
create_file "app/helpers/layout_helper.rb", layout_helper

puts "go to directory and let rails go ;)"
puts "$ cd #{app_name}"
puts "$ rake db:create"
puts "$ ./script/rails g scaffold Pages title:string body:text"
puts "edit config/routes.rb and uncomment root :to => 'pages#index'"
puts "$ ./script/rails s"


{% endhighlight %}
