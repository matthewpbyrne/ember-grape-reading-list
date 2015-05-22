import Protected from "./protected";

export default Protected.extend({
  beforeModel: function() {
    if(!this.get('session.isAuthenticated')) {
      this.set('session.afterLoginRoute', 'teams');
      this.transitionTo('login');
    }
  },
  model: function() {
    return this.store.findAll('team');
  },
  redirect: function() {
    var team = this.modelFor('teams').get('firstObject');
    this.transitionTo('team', team);
  }
});
