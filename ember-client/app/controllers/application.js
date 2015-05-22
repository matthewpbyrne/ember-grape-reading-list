import Ember from 'ember';

export default Ember.ArrayController.extend({
  currentTime: null,
  currentTenant: function() {
    return this.get('currentUser.tenant');
  }.property('currentUser'),

  currentUser: function() {
    var userId = this.get("session.secure.user_id");
    return this.filter(function(user) {
      return user.get('id') == userId;
    }).get('firstObject');
  }.property('@each.isCurrentUser'),

  isLoginPath: function(){
    return this.get('currentPath') == 'login';
  }.property('currentPath'),

  observeSession: function() {
    this.send("sessionChanged");
  }.observes("session.isAuthenticated"),

  actions: {
    invalidateSession: function(){
      this.get('session').invalidate();
    }
  }
});
