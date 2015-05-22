import DS from 'ember-data';

export default DS.Model.extend({
  read:      DS.attr('boolean'),
  createdAt: DS.attr('date'),
  updatedAt: DS.attr('date'),
  article:   DS.belongsTo('article'),
  user:      DS.belongsTo('user'),
  lastChangedAt: function() {
    var t = this.get('updatedAt');
    if ((typeof t == "undefined") || (t == null)) {
      t = this.get('createdAt');
    }
    return t;
  }.property('createdAt', 'updatedAt')
});
