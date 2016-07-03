class Card < ActiveRecord::Base
  has_and_belongs_to_many :labels
  has_and_belongs_to_many :members
  belongs_to :sprint

  SIZE_MAP = {'s' => 1, 'S' => 1, 'm' => 3, 'M' => 3, 'l' => 5, 'L' => 5}

  scope :with_label, -> (label_name = nil) { label_name.present? ? Label.find_by_name(label_name).cards : self.all }

  class << self
    def size(card)
      matches = /\[(s|m|l)\]/i.match(card.name)
      Card::SIZE_MAP[matches.present? ? matches[1] : 's']
    end
  end
end
