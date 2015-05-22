import DS from 'ember-data';

export default DS.Model.extend({
  leader:          DS.attr('boolean'),
  name:            DS.attr('string'),
  createdAt:       DS.attr('date'),
  updatedAt:       DS.attr('date'),
  tenant:          DS.belongsTo('tenant'),
  articleListings: DS.hasMany('article-listing'),
  users:           DS.hasMany('user'),

  getOtherUsersOnTeam: function(user) {
    return this.get('users').filter(function(u) {
      return u.get('id') !== user.get('id');
    });
  },

  isLeader: function() {
    return this.get('leader');
  }.property('leader')
});
