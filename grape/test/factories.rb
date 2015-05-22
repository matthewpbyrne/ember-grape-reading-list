FactoryGirl.define do
  factory :article do
    sequence(:url) { |n| "wiki.org/articles/#{n}" }
  end

  factory :article_interaction do
    article_id 1
  end

  factory :team do
    tenant_id 1
    sequence(:name) { |n| "Team #{n}" }
  end

  factory :tenant do
    sequence(:name) { |n| "Tenant #{n}" }
    sequence(:domain_name) { |n| "tenant-#{n}.com" }
  end

  factory :user do
    name        "John Doe"
    email       'john@example.com'
    password    'password'
    password_confirmation 'password'
    tenant_id   { create(:tenant).id }
    admin       false
  end
end
