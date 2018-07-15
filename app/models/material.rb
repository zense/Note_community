class Material < ApplicationRecord
    acts_as_votable
    belongs_to :user
    has_many :reviews
end
