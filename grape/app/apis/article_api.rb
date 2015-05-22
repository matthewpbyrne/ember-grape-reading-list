class ArticleAPI < Grape::API
  helpers AuthHelpers

  before do
    authenticate!
  end

  post '/' do
    a = Article.find_or_create(:url => params[:article][:url])
    { article: a.to_hash }
  end
end
