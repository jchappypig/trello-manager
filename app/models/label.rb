class Label < ActiveRecord::Base
  has_and_belongs_to_many :cards

  class << self
    def other
      Label.find_by_name('Other')
    end

    def find_by_trello_identifier_or_default(trello_id)
      where("trello_identifier = ? or name='Other'", trello_id).first
    end
  end
end
