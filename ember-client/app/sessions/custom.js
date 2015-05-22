import DS from 'ember-data';
import Ember from "ember";
import Session from "simple-auth/session";

export default Session.extend({
  user: function() {
    var userId = this.get('secure.user_id');
    if (!Ember.isEmpty(userId)) {
      return DS.PromiseObject.create({
        promise: this.container.lookup('store:main').find('user', userId)
      });
    }
  }.property('secure.user_id')
});
