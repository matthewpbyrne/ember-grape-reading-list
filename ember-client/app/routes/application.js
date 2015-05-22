import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin';
import Ember from 'ember';

export default Ember.Route.extend(ApplicationRouteMixin,{
  model: function(){
    if(this.get('session.isAuthenticated')) {
      return this.store.fetchAll('user');
    }
  },
  redirect: function() {
    this.transitionTo('teams');
  },

  actions: {
    openModal: function(modalName, model) {
      this.controllerFor(modalName).set('model', model);
      return this.render(modalName, {
        into: 'application',
        outlet: 'modal'
      });
    },

     closeModal: function() {
       return this.disconnectOutlet({
         outlet: 'modal',
         parentView: 'application'
      });
    },

    sessionChanged: function() {
      this.refresh();
    },

    sessionAuthenticationSucceeded: function(){
      var transitionTo = this.get('session.afterLoginRoute');
      this.set('session.afterLoginRoute', null);
      if (typeof transitionTo === "undefined" || transitionTo === null) {
        transitionTo = 'index';
      }
      this.transitionTo(transitionTo);
    },

    sessionInvalidationSucceeded: function(){
      this.transitionTo('index');
    }
  }
});
