class Card < ActiveRecord::Base
  belongs_to :sprint

  SIZE_MAP = {'s' => 1, 'S' => 1, 'm' => 3, 'M' => 3, 'l' => 5, 'L' => 5}
  NEW_FEATURE_FLAG = '[NEW]'
  BUG_FLAG = '[BUG]'

  scope :with_label, -> (label_name = nil) { label_name.present? ? where('labels ILIKE ?', "%#{label_name}%") : self.all }
  scope :bugs, -> { where('name ILIKE ?', "%#{BUG_FLAG}%")}
  scope :new_features, -> { where('name ILIKE ?', "%#{NEW_FEATURE_FLAG}%")}
  scope :maintenance_works, -> { where.not('name ILIKE ? or name ILIKE ?', "%#{NEW_FEATURE_FLAG}%", "%#{BUG_FLAG}%")}
  scope :with_top_label, -> (label_name = nil) { label_name.present? ? where(top_label: label_name) : self.all }

  class << self
    def size(card)
      matches = /\[(s|m|l)\]/i.match(card.name)
      Card::SIZE_MAP[matches.present? ? matches[1] : 's']
    end
  end

  def new_feature?
    name.upcase.include?(NEW_FEATURE_FLAG)
  end

  def bug?
    name.upcase.include?(BUG_FLAG)
  end
end
