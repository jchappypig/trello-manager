class Card < ActiveRecord::Base
  belongs_to :sprint

  SIZE_MAP = {'s' => 1, 'S' => 1, 'm' => 3, 'M' => 3, 'l' => 5, 'L' => 5}

  scope :with_label, -> (label_name = nil) { label_name.present? ? where('labels ILIKE ?', "%#{label_name}%") : self.all }

  class << self
    def size(card)
      matches = /\[(s|m|l)\]/i.match(card.name)
      Card::SIZE_MAP[matches.present? ? matches[1] : 's']
    end
  end
end
