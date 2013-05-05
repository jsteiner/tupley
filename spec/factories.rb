FactoryGirl.define do
  factory :task do
    name 'task name'
    user
  end

  factory :tag do
    name 'Buy eggs'

    factory :default_tag do
      default true
    end
  end
end
