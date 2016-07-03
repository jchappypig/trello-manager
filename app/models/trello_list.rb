class TrelloList

  CURRENT_DONE = {name: 'Current Sprint done', trello_identifier: '577346f0e6097163952f9cf9'}
  HISTORICAL_DONE = {name: 'Historical Done', trello_identifier: '564e6bce352ecdb339f7866c'}
  WIP = {name: 'Work in Progress', trello_identifier: '564e6c656aaddb6442b935dd'}
  UP_NEXT = {name: 'Up Next', trello_identifier: '565fd24d92256e645cab143f'}
  IN_REVIEW = {name: 'Pull Pool/Parking', trello_identifier: '565fd24d92256e645cab143f'}

  ALL = [UP_NEXT, WIP, IN_REVIEW, CURRENT_DONE, HISTORICAL_DONE]

  class << self
    def find_by_trello_identifier(trello_identifier)
      ALL.select{|list| list['trello_identifier'] == trello_identifier}.first
    end

    def find_by_name(name)
      ALL.select{|list| list['name'] == name}.first
    end
  end
end