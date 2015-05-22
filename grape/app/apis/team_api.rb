class TeamAPI < Grape::API
  helpers AuthHelpers
  helpers FormattingHelpers

  before do
    authenticate!
  end

  get '/' do
    teams = current_user.teams

    {
      teams: formatted_teams(teams),
      article_listings: formatted_teams_listings(teams),
      articles: formatted_teams_articles(teams),
      article_interactions: formatted_teams_interactions(teams),
      users: formatted_users_data,
      tenants: tenant_data
    }
  end

  get '/:id', requirements: { id: /[0-9]*/ } do
    id   = params[:id].to_i
    team = current_user.teams.find{ |team| team.id == id }

    {
      team: formatted_team(team),
      article_listings: formatted_team_listings(team),
      articles: formatted_team_articles(team),
      article_interactions: formatted_team_interactions(team),
      users: formatted_users_data,
      tenants: tenant_data
     }
  end

  post '/' do
    team = Team.create(:name => params[:name],
                       :tenant_id => Tenant.current_id )
    { team: team.to_hash }
  end

  post '/:id/memberships/', requirements: { id: /[0-9]*/ } do
    id      = params[:id].to_i
    user_id = params[:user_id].to_i
    team    = current_user.teams.find{ |team| team.id == id }
    membership = TeamsUser.find_or_create(:team_id => team.id,
                                          :user_id => user_id)
    { membership: membership.to_hash }
  end

  post '/:id/article_listings/', requirements: { id: /[0-9]*/ } do
    id         = params[:id].to_i
    team       = current_user.teams.find{ |team| team.id == id }

    a_id = params[:article_listing][:article_id]
    comm = params[:article_listing][:comment]
    al   = ArticleListing
             .find_or_create(:team_id => team.id,
                             :article_id => a_id){ |l| l.comment = comm }

    { article_listing: al.to_hash }
  end
end
