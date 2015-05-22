import Ember from 'ember';
import Base from 'simple-auth/authorizers/base';

export default Base.extend({
  authorize: function(jqXHR) {
    var accessToken = this.get('session.secure.access_token');
    if (this.get('session.isAuthenticated') && !Ember.isEmpty(accessToken)) {
      jqXHR.setRequestHeader('Access-Token', accessToken);
    }
  }
});
