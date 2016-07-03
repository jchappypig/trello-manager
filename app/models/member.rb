class Member
  PHOEBE = {name: 'Phoebe', trello_identifier: '54c9c4df04ebb717eec26520'}.with_indifferent_access
  PHIL = {name: 'Phil Jacob', trello_identifier: '5448736e75e3bf015aeb8a28'}.with_indifferent_access
  DAISY = {name: 'Daisy Xu', trello_identifier: '56b957acb9656015e320e127'}.with_indifferent_access
  JOHNNY = {name: 'Johnny Woo', trello_identifier: '5654291ff267c8e66c2846e56d'}.with_indifferent_access
  HUAN = {name: 'Huanhuan', trello_identifier: '52ef549539ceeec275e2b8ee'}.with_indifferent_access

  ALL = [PHOEBE, PHIL, DAISY, JOHNNY, HUAN]

  class << self

    def find_by_trello_identifier(trello_identifier)
      ALL.select{|label| label['trello_identifier'] == trello_identifier}.first
    end

    def to_field(members)
      members.uniq.compact.map{|label| label['name']}.join(' | ')
    end
  end
end
