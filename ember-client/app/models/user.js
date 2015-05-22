import DS from 'ember-data';

export default DS.Model.extend({
  name:                 DS.attr('string'),
  tenant:               DS.belongsTo('tenant'),
  articleInteractions:  DS.hasMany('article-interaction'),
  teams:                DS.hasMany('team')
});
