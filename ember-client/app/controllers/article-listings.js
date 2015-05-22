import Ember from 'ember';

export default Ember.ArrayController.extend({
  needs: ['application', 'team'],
  maxPerPage: 10,
  currentPage: Ember.computed.alias("controllers.team.articlesPage"),
  currentTeam: Ember.computed.alias("controllers.team.currentTeam"),
  currentUser: Ember.computed.alias("controllers.application.currentUser"),
  sortOrder:   Ember.computed.alias("controllers.team.sortOrder"),
  sortProp:    Ember.computed.alias("controllers.team.sortProp"),

  displayedListings: function() {
    var perPage = this.get('maxPerPage');
    var page    = this.get('currentPage');
    var start   = (page-1) * perPage;
    var end     = page * perPage;
    var sort    = this.get('listings').sortBy(this.get('sortProp'));

    if(this.get('sortOrder') == 'asc') {
      sort = sort.toArray().reverse();
    }
    return sort.slice(start, end);
  }.property('listings', 'currentPage', 'sortOrder', 'sortProp'),

  listings: function() {
    return this.get('currentTeam.articleListings');
  }.property('currentTeam', 'currentTeam.articleListings'),

  listingsCount: function() {
    return this.get('listings.length');
  }.property('listings'),

  pageCount: function() {
    return Math.ceil(this.get('listingsCount') / this.get('maxPerPage'));
  }.property('listings', 'maxPerPage'),

  paginationRequired: function() {
    return this.get('pageCount') > 1;
  }.property('listingsCount', 'pageCount')
});
