import DS from "ember-data";

export default DS.ActiveModelAdapter.extend({
  host: 'http://localhost:9292',
  namespace: 'v1'
});
