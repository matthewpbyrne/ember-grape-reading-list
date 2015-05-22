class ArticleInteractionAPI < Grape::API
  helpers AuthHelpers

  before do
    authenticate!
  end

  post '/' do
    filtered = params[:article_interaction]
    ai = ArticleInteraction.create :read       => filtered[:read],
                                   :article_id => filtered[:article_id],
                                   :user_id    => current_user.id
    { article_interaction: ai.to_hash }
  end

  put '/:id/', requirements: { id: /[0-9]*/ } do
    ai = ArticleInteraction.find(id: params[:id]).update :read => params[:article_interaction][:read]
    { article_interaction: ai.to_hash }
  end
end
