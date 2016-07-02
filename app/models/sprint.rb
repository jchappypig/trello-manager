class Sprint < ActiveRecord::Base
  has_many :cards

  class << self
    def which(date)
      Sprint.where('start <= ?', date.to_date).where('finish >= ?', date.to_date).first
    end
  end
end
