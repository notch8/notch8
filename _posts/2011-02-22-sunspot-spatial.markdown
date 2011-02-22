---
layout: posts
title: Adding Solr-Spatial-Light back to Sunspot
excerpt: Sunspot removed built in solr-spatial-light support with the release of 1.2.0. Here is how to use it anyway
---

Geohashing is super cool, but it doesn't allow you to sort by distance (yet) and there are still some major issues when it comes to accuracy. Solr-spatial-light gives you accuracy and sortability, but it is more difficult to scale.  To me (and my clients) "works but takes more hardware" trumps "doesn't work but effecient".  Word on the street is that the next release of Sunspot will once again support solr-spatial-light and that support will stay in until Geohashing becomes feature complete.  In the meantime here are the steps to getting solr-spatial-light working with Sunspot 1.2

In your searchable block add:
{% highlight ruby %}
float :lat, :as => 'lat'
float :lng, :as => 'lng'
{% endhighlight %}
These should be the latitude and longitude of your object.  I'm using [acts_as_geocodable](http://graticule.rubyforge.org/plugin.html) to do my geocoding and storing the lat and lng as doubles in my db.

In your search block you can filter using the adjust_solr_params method.  I use a model to wrap my searches with a set of attr_accessors which get set by the form (that is where self.zipcode and self.with_in come from.  The first is a postal code, the second is the radius number in miles.
{% highlight ruby %}
# distance filters
if !self.zip_code.blank? && !self.with_in.blank? && code = Geocode.geocoder.locate(self.zip_code)
  adjust_solr_params do |params|
    params[:spatial] = "{!radius=#{self.with_in.to_i}.0 sort=true}#{code.latitude.to_f},#{code.longitude.to_f}"
    # spatial={!radius=10.0 sort=true}lat:40.0,lng:-70.0
  end
end
{% endhighlight %} 
And that's it. You now have solr-spatial-light support which is still supported by [WebSolr](http://websolr.com) and is running beautifully in my production environment.
