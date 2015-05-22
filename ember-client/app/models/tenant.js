import DS from 'ember-data';

export default DS.Model.extend({
  domainName: DS.attr('string'),
  name:       DS.attr('string'),
  users:      DS.hasMany('user')
});
