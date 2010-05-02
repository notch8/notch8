{% for post in site.posts limit:5 %}
  ##[{{ post.title }}]({{ post.url }})
  {{ post.content }}
  *Posted on {{ post.date | date_to_long_string }}.*
{% endfor %}