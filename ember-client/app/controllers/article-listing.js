import Ember from 'ember';

export default Ember.Controller.extend({
  needs: ['application', 'team'],
  currentTeam: Ember.computed.alias("controllers.team.currentTeam"),
  currentUser: Ember.computed.alias("controllers.application.currentUser"),

  colleagues: function() {
    return this.get('currentTeam').getOtherUsersOnTeam(this.get('currentUser'));
  }.property('currentTeam', 'currentTeam'),

  colleagueCount: function() {
    return this.get('colleagues').get('length');
  }.property('colleagues'),

  colleagueReadCount: function() {
    return this.get('model.article')
             .getReadCountForUsers(this.get('colleagues'));
  }.property('model', 'colleagues'),

  isReadByAllColleagues: function() {
    return this.get('colleagueReadCount') == this.get('colleagueCount');
  }.property('colleagueCount', 'colleagueReadCount'),

  isReadByUser: function() {
    return this.get('model.article').isReadByUser(this.get('currentUser'));
  }.property('model', 'currentTime', 'currentUser'),

  toggleInteraction: function() {
    var i = this.get('userInteraction');
    if ((typeof i == "undefined") || (i == null)) {
      i = this.store.createRecord('article-interaction',{
            article: this.get('model.article'),
            read:    true,
            user:    this.get('currentUser')
          });
    } else {
      i.toggleProperty('read');
    }
    i.save();
  }.observes('isReadByUser'),

  updatedAt: function() {
    return this.get('userInteraction').get('lastChangedAt');
  }.property('userInteraction.updatedAt', 'userInteraction.createdAt'),

  userInteraction: function() {
    return this.get('model.article')
             .getUserInteraction(this.get('currentUser'));
  }.property('currentUser')
});
