import DS from 'ember-data';

export default DS.Model.extend({
  url:                 DS.attr('string'),
  articleInteractions: DS.hasMany('article-interaction'),
  articleListings:     DS.hasMany('article-listing'),

  getReadCountForUsers: function(users) {
    return this.get('articleInteractions').filter(function(inter) {
      return users.contains(inter.get('user')) && inter.get('read');
    }).get('length');
  },

  getUserInteraction: function(user) {
    return this.get('articleInteractions').filter(function(i) {
      return i.get('user') == user;
    }).get('firstObject');
  },

  isReadByUser: function(user) {
    var interaction = this.getUserInteraction(user);
    if ((typeof interaction == "undefined") || (interaction == null)) {
      return false;
    } else {
      return interaction.get('read');
    }
  }
});
