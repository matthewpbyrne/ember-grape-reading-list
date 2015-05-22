## Welcome

Welcome to Team Reading List, a sample social reading application for workers on different teams to keep track of read articles.  It's composed of 2 separate applications - an Ember.js client and a RESTful API server built with Grape/Ruby.

The intention is to be a useful demo example (i.e. not a production-ready application) of how to get several actually concepts working:
  * [Ember Simple Auth](https://github.com/simplabs/ember-simple-auth)
  * Authentication and redirects in an Ember app
  * Displaying Ember data using association/relationship structure, not a simple 1-1 display of models
  * Using [Warden::OAuth2](https://github.com/opperator/warden-oauth2) to build an authenticated Grape-based API
  * Using [Sequel](http://sequel.jeremyevans.net) as the ORM, not ActiveRecord, and therefore not having [ActiveModel::Serializers](https://github.com/rails-api/active_model_serializers)
  * [Minitest](https://github.com/seattlerb/minitest) with Grape / Sequel
  * Google's [Material](http://example.com), with thanks to [ember-cli-materialize]https://github.com/sgasser/ember-cli-materialize and [Materialize]http://materializecss.com

## Getting Started

#### Runing the API-server

After git clone:
```
cd grape
bundle install
rake db:migrate
```

Now you need to populate the (SQLite) databse

```
ruby db/seeds.rb
```

Now you can fire up the server:
```
rackup -Ilib config.ru -p 9292
```

####Serving the ember app

```
cd ember-client
ember s
```

#### Running Tests (Grape application only)

```
cd grape
rake test
```

## Other comments

As I hope this can prove to be a useful working example of how to stitch a few things together, you can let me know of any relevant problems, queries, or suggestions: [@matthewpbyrne](http://twitter.com/matthewpbyrne)
