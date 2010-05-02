---
layout: posts
title: Counting Retweets - Or Why Is This Hard
excerpt: On <a href='http://measuredvoice.com'>Measured Voice</a> we try and count the retweets for a given tweet.  The first part that makes that hard is defining what a retweet really is. Is it Twitters new offical retweets? Any tweet that contains the exact same text? The same link? Some part of the same text?  Then you get into RT, via and other attributions.  It gets pretty confusing pretty fast.

---
On [Measured Voice](http://measuredvoice.com) we try and count the retweets for a given tweet.  The first part that makes that hard is defining what a retweet really is. Is it Twitters new offical retweets? Any tweet that contains the exact same text? The same link? Some part of the same text?  Then you get into RT, via and other attributions.  It gets pretty confusing pretty fast.

What we decided for [MV](http://measuredvoice.com) was that we need to keep track both offical retweets and the more traditional retweets.  We'd ultimately like to keep track of them separately, but at the moment the Twitter API makes that tough to do. So for the moment we're just keeping one retweet count using this algorithm:

- Search for the user name of the Twitter account
- Go through each result and check if we've seen it before
- If we haven't seen it find the message it matches and increment the retweet counter

In theory that should work fine... but it doesn't. When you do a search for a user name the Twitter API just flat does not return all the results.  Lets say we have the following tweet: "There are 19 million new sexually transmitted infections each year. Most have no symptoms. Get yourself tested: http://j.mp/9ikwGM".  We'd search for USAgov (note that page 1 of this search had no matches):

![Search Page 2](/images/usagov-twitter-2.png "Search Page 2")


Here is what we get if we search for the link from that message:

![Link Search](/images/twitter-link-search.png "Link Search")

So the first page shows 6 messages that we would count (the two in green don't have the same link, so we'd miss them).  But when we search for the link it self we see the 6 from the first result set and 4 that we don't.  Those 4 in yellow NEVER show up in the USAgov search.  Where did they go?

In fact, when we survey the various services this is what we find:

Gina's Method: 5
MV method: 6
Twitter mentions count: 6
Twitter URL search: 10
Twitter Username search: 6
OtterAPI: 10 (but a different 10!)
Retweet.net: 0
TweetMeme: 12 (counts original url)

Why is this so hard? Why can't I go "http://api.twitter.com/1/statuses/id/retweet_count" and just get the number.  Twitter makes it pretty clear that they have a hard time keeping up with API demand, so why are they asking me to pull each and every result over and over and manually count them. There are messages on the Google Group as far back as 2008 saying they are working on this, but I'm curious how others are solving this problem.  Am I missing something obvious?