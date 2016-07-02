class Card < ActiveRecord::Base
  has_and_belongs_to_many :labels
  has_and_belongs_to_many :members
  belongs_to :sprint

  SIZE_MAP = {'s' => 1, 'S' => 1, 'm' => 3, 'M' => 3, 'l' => 5, 'L' => 5}

  scope :with_label, ->(label_name) do Label.first.cards
  end

end
