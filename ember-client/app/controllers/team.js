import Ember from 'ember';

export default Ember.Controller.extend({
  needs: ['application', 'article-listings'],
  articlesPage: 1,
  sortOrder:    'desc',
  sortProp:     'createdAt',

  currentUser:        Ember.computed
                        .alias("controllers.application.currentUser"),
  displayedListings:  Ember.computed
                        .alias("controllers.article-listings.displayedListings"),
  listingsCount:      Ember.computed
                        .alias("controllers.article-listings.listingsCount"),
  pageCount:          Ember.computed
                        .alias("controllers.article-listings.pageCount"),
  paginationRequired: Ember.computed
                        .alias("controllers.article-listings.paginationRequired"),

  currentTeam: function() {
    return this.get('model');
  }.property('model.id'),

  saveListing: function(article, comment){
    this.store.createRecord('article-listing', {
      article: article,
      comment: comment,
      team:    this.get('model')
    }).save();
  },

  actions: {
    createlisting: function(url, comment) {
      var article = this.store.all('article').filter(function(a) {
                      return a.get('url') == url;
                    }).get('firstObject');

      var self = this;
      if ((typeof article == "undefined") || (article == null)) {
        article = this.store.createRecord('article', {url: url})
                    .save().then(function(a){
                      self.saveListing(a, comment);
                    });
      } else {
        this.saveListing(article, comment);
      }
    },

    sortBy: function(sortProp, sortOrder) {
      this.setProperties({
        sortOrder: sortOrder,
        sortProp:  sortProp
      });
    }
  }
});
