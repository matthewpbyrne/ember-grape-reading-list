module FormattingHelpers
  extend Grape::API::Helpers

  def user_data
    team_ids = current_user.teams.map(&:id)
    current_user.to_hash.merge(team_ids: team_ids)
  end

  def formatted_team team
    to_merge = {}
    to_merge[:leader] = current_user.is_team_leader? team
    to_merge[:article_listing_ids] = team.article_listings.map(&:id)
    to_merge[:user_ids] = team.users.map(&:id)
    team.to_hash.merge to_merge
  end

  def formatted_teams teams
    teams.map{ |team| formatted_team team }
  end

  def formatted_team_articles team
    team.article_listings.map(&:article).uniq.compact
  end

  def formatted_teams_articles teams
    teams.map{ |team| formatted_team_articles team }.flatten.uniq
  end

  def formatted_team_interactions team
    team.article_interactions
  end

  def formatted_teams_interactions teams
    arr = []
    teams.each{ |team| arr << formatted_team_interactions(team).to_hash.values }
    arr.flatten!
    arr
  end

  def formatted_team_listings team
    team.article_listings
  end

  def formatted_teams_listings teams
    teams.map{ |team| formatted_team_listings team }.flatten
  end

  def formatted_users_data
    users = current_user.tenant.users
    users.map do |u|
      # TODO: Redact sensitive data
      u.to_hash
    end
  end

  def tenant_data
    tenant   = current_user.tenant
    user_ids = tenant.users.map(&:id)
    team_ids = current_user.teams.map(&:id)
    [tenant.to_hash.merge(user_ids: user_ids, team_ids: team_ids)]
  end
end
