class Syncer
  class << self
    def from_trello(trello_card)
      card = CurrentCard.new
      card.name = trello_card.name
      card.url = trello_card.url
      card.trello_identifier = trello_card.id
      card.list = trello_card.list.name
      card.sprint = Sprint.which(trello_card.last_activity_date)
      card.labels = trello_card.card_labels.map{|card_label| Label.find_by_trello_identifier_or_default(card_label['id'])}.uniq.compact
      card.members = trello_card.member_ids.map{|member_trello_id| Member.find_by_trello_identifier(member_trello_id)}.compact
      card.estimated_size = size(trello_card)
      card.save
    end

    def size(card)
      matches = /\[(s|m|l)\]/i.match(card.name)
      Card::SIZE_MAP[matches.present? ? matches[1] : 's']
    end
  end
end