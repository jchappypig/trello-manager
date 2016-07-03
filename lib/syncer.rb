class Syncer
  class << self
    def from_trello(trello_card)
      trello_card = OpenStruct.new(JSON.parse(trello_card.to_json))
      card = CurrentCard.new
      card.name = trello_card.name
      card.url = trello_card.url
      card.trello_identifier = trello_card.id
      card.list = TrelloList.find_by_trello_identifier(trello_card.list_id)
      card.sprint = Sprint.which(trello_card.last_activity_date)
      card.labels = trello_card.card_labels.map{|card_label| Label.find_by_trello_identifier_or_default(card_label['id'])}.uniq.compact
      card.members = trello_card.member_ids.map{|member_trello_id| Member.find_by_trello_identifier(member_trello_id)}.compact
      card.estimated_size = Card.size(trello_card)

      card.save
    end

    def mass_from_trello(trello_cards)
      card_attributes = %w(name url trello_identifier list sprint_id estimated_size type created_at updated_at)
      sprint_id = nil
      cards_as_json = JSON.parse(trello_cards.to_json)

      values = cards_as_json.reduce([]) do |values, card_as_json|
        card = OpenStruct.new(card_as_json)
        name = card.name
        url = card.url
        trello_identifier = card['id']
        list = TrelloList.find_by_trello_identifier(card.list_id)
        sprint_id = sprint_id || Sprint.last.id
        estimated_size = Card.size(card)

        values << "($$#{name}$$, $$#{url}$$, $$#{trello_identifier}$$, $$#{list}$$, #{sprint_id}, #{estimated_size}, $$#{CurrentCard.name}$$, $$#{Time.now.utc}$$, $$#{Time.now.utc}$$)"
      end

      sql = "INSERT INTO cards (#{card_attributes.join(', ')}) VALUES #{values.join(', ')};"

      ActiveRecord::Base.connection.execute sql
    end
  end
end