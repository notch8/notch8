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

    $ rails new tutor -d mysql -T -J -m rails3_template.rb

    $ cd tutor

    $ rake db:create

    $ ./script/rails g scaffold Page title:string body:text
{% endhighlight %}

edit route file:

  uncomment root :to => "pages#index"

{% highlight bash %}
    $ rake db:migrate

    $ ./script/rails s
{% endhighlight %}
