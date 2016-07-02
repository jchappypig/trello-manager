class Card
  attr_accessor :name, :labels, :status, :sprint, :owners, :url

  class << self
    def from_trello(trello_card)
      card = Card.new
      card.name = trello_card.name
      card.url = trello_card.url
      card.owners = trello_card.members.map(&:full_name).join(', ')
      card.labels = trello_card.card_labels.map { |card_label| card_label['name']}
      card
    end

    def bulk_from_trello(trello_cards)
      trello_cards.map do |trello_card|
        from_trello(trello_card)
      end
    end
  end

end