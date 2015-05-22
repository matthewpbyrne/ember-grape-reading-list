import ApplicationAdapter from './application';

export default ApplicationAdapter.extend({
  buildURL: function(typeKey, id, snapshot, requestType){

    var host    = this.get('host');
    var ns      = this.get('namespace');
    var teamId  = snapshot.belongsTo('team', { id: true });

    return host + '/' + ns + '/teams/' + teamId + '/article_listings';
  }
});
