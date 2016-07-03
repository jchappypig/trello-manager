class Label
  MILLI = {name: 'Milli', trello_identifier: '56e78fd7152c3f92fd6c172c'}.with_indifferent_access
  HOME_NOW = {name: 'Home Now', trello_identifier: '57269578b0dfecc6d11f84ce'}.with_indifferent_access
  LM_MARKETING = {name: 'LM Marketing', trello_identifier: '572191a5b0dfecc6d11481aa'}.with_indifferent_access
  LM_LEAD = {name: 'LM Lead', trello_identifier: '564e6a4119ad3a5dc235de8b'}.with_indifferent_access
  OTHER = {name: 'Other', trello_identifier: ''}.with_indifferent_access

  ALL = [MILLI, HOME_NOW, LM_MARKETING, LM_LEAD, OTHER]

  class << self

    def find_by_trello_identifier(trello_identifier)
      ALL.select{|label| label['trello_identifier'] == trello_identifier}.first || OTHER
    end

    def to_field(labels)
      labels.uniq.compact.map{|label| label['name']}.join(' | ')
    end
  end
end
