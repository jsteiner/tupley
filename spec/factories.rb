FactoryGirl.define do
  factory :task do
    name 'task name'
    user
  end

  factory :tag do
    name 'Buy eggs'

    trait :default do
      default true
    end

    trait :shopping do
      name 'shopping'
    end

    trait :work do
      name 'work'
    end

    trait :todo do
      name 'todo'
    end
  end
end
