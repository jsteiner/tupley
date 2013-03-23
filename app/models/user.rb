class User < ActiveRecord::Base
  include Clearance::User

  acts_as_tagger

  has_many :tasks
end
