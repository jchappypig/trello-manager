class Sprint < ActiveRecord::Base
  has_many :cards

  class << self
    def which(date)
      Sprint.where('start <= ?', date.to_date).where('finish >= ?', date.to_date - 1.days).first
    end

    def current
      which(Time.now.utc)
    end

    def previous
      which(Time.now.utc - 2.weeks)
    end
  end
end
