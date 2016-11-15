FactoryGirl.define do
  factory :post do
    title {"#{Faker::ChuckNorris.fact} #{Faker::Name.title} #{rand(100)}"}
    body {Faker::Hipster.paragraph}
  end
end
