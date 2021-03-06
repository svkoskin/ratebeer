FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :user2, class: User do
    username "lissu"
    password "ihqD44"
    password_confirmation "ihqD44"
  end

  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :brewery do
    name "anonymous"
    year 1900
  end
  
  factory :beer do
    name "anonymous"
    brewery
    style "Lager"
  end
end
