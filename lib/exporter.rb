require 'csv'

class Exporter
  class << self
    def cards_to_csv(cards)
      # attributes = %w{name status sprint project}
      attributes = %w{name}

      CSV.generate(headers: true) do |csv|
        csv << attributes

        cards.each do |card|
          csv << attributes.map{ |attr| card.send(attr) }
        end
      end
    end
  end
end