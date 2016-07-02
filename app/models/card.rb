class Card < ActiveRecord::Base
  has_and_belongs_to_many :labels
  has_and_belongs_to_many :members
  belongs_to :sprint
end
