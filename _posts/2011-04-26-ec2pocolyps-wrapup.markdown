---
layout: posts
title: EC2pocolyps Wrapup
excerpt: The internet was broken and we owe you an appology
---

# What happened

The long and short of it is that Amazon's cloud services failed and failed massively.  Heroku, which many of our customers use, is built on top of Amazon, as are WebSolr, Exceptional and MongoHQ.  These services where all heavily hurt by this unprecedented outage.  Amazon is claiming that this outage is not a breach of the SLA, but the bottom line is that the outage was massive and the response was feeble.  We where told that servers would be back on line in minutes when things first went down, and that they where working on the problem and it would be fixed "soon" basically every hour there after.  Heroku on the other hand handled the outage as best they could, updating status.heroku.com quickly and accurately while being clear what promises they were and were not making.

# Impact on Notch8

First off, I'm very proud to say that none of Notch8's high availability customers experienced down time because of this outage.  High availability is a trade off. It is, after all, expensive to maintain 2 full sets of architecture by two separate providers and two separate locations.  We work hard to make things rock solid, and even with this major outage we were able to weather the storm without having to frantically scramble about.  An event of this scale did mean degraded performance for some, though once we disabled the Exceptional javascript load (thanks to Jed Sundwall for noticing that) the "backup" servers where able to handle the load we asked of them during the outage.

For those not on a high availability maintenance plan, things were definitely rockier.  In fact, they were unacceptably rockier.  I want to define my quality expectations here and then talk about in what ways they were not met and what will happen going forward.

## Maintenance Customers:
  Those who have Notch8 maintaining their code and servers but who do not need to pay the extra server and sys admin costs of high availability can expect occasional down time.  We define occasional down time as a few minutes here and there and maybe an hour or two in the event of something major.  It doesn't mean down for two to three days.  Yes, no data was lost even on servers whose EBS volumes did not come back at all.  And yes, we were there to hold your hands and explain things as they happened.  But it was still to long for me to be satisfied, and for that I apologize.  We are going to be implementing smoother transitions to backup servers in the future which I'll layout below.

## Develop Only Customers:
  We are not abandoning you if you opt out of a maintenance plan.  We take a lot of pride in our work and are choosy about working on things we can be passionate about.  It does mean that an outage like this will rely on you telling us that your services are down and authorizing a spend if you need to fail over to a backup stack.  For you, an event like this may mean being down for two or three days until the underlying servers can be restored and it means that if we're scrambling with other customers that we can only put you in the queue and get to you as soon as possible.  Not having a restoration plan in place will increase the time it costs when an incident happens.  But we should always be able to move you over and get you back live.  As I look at the land scape at the moment, were many of you only have the barest of backups so that I can sleep at night, I don't feel like that is necessarily the case.  It should be, and I'm sorry that I haven't made that more clear.

# What is Going to Change
In order to meet the standards we've set we are going to be rolling out a few things:

1) Better communication of site and service down time.  We're going to be implementing a new dashboard page were those of you on maintenance plans will be able to get aggregated data as to what is going on.

2) Accelerated deployment from backups for maintenance customers.  We didn't start this soon enough and then hit some bumps in this work flow.  We'll be ironing those out and testing the transition from the primary servers to their backup counter parts.

3) A free backup audit for all customers (regardless of maintenance plan).  We'll be putting together a document that shows your current stack, what is where and discussing your options in the even of a failure.  This document will be pretty simple and hopefully really digestible.  We'll also be showing you pricing should you decide you want to change to a different plan.

These things are going to take a little time to get in place, so please bare with us.

# Why We Don't Think We Should Move Stacks
Amazon and Heroku have both learned a ton from this outage.  Heroku is for sure going to be making changes to address the gaps.  It could happen to anyone and switching providers doesn't really protect us much anyway.  Heroku has responded [here](http://status.heroku.com/incident/151) by taking responsability and providing transparancy, which is exactly what I'd hope for from a provider.  Not only do we not gain anything by moving off Heroku, they are a responsive company, and will be better equipped to to handle an outage of this magnitude because of this outage.  The benefits of Heroku are clear... easy "right sizing" of servers and services.  There is absolutely no easier way for us to deploy and scale your sites.  I feel like with the addition of smoothing over our catastrophe response we can feel safe we're getting the best risk / cost trade off that we can.

# Status Now
All services are up and running.  We've verified everything we can think of, so if anything is found to be still down please let us know.