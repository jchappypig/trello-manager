class Member
  PHOEBE = {name: 'Phoebe', trello_identifier: ''}.with_indifferent_access
  PHIL = {name: 'Phil Jacob', trello_identifier: ''}.with_indifferent_access
  DAISY = {name: 'Daisy Xu', trello_identifier: ''}.with_indifferent_access
  JOHNNY = {name: 'Johnny Woo', trello_identifier: ''}.with_indifferent_access
  HUAN = {name: 'Huanhuan', trello_identifier: ''}.with_indifferent_access

  ALL = [PHOEBE, PHIL, DAISY, JOHNNY, HUAN]

  class << self

    def find_by_trello_identifier(trello_identifier)
      ALL.select{|member| member['trello_identifier'] == trello_identifier}.first
    end

    def to_field(members)
      members.uniq.compact.map{|member| member['name']}.join(' | ')
    end
  end
end
