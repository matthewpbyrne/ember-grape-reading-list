import DS from 'ember-data';

export default DS.Model.extend({
  comment:   DS.attr(),
  createdAt: DS.attr('date'),
  updatedAt: DS.attr('date'),
  article:   DS.belongsTo('article'),
  team:      DS.belongsTo('team')
});
