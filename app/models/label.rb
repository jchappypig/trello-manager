class Label
  MILLI = {name: 'Milli', trello_identifier: '56e78fd7152c3f92fd6c172c', priority: 5}.with_indifferent_access
  HOME_NOW = {name: 'Home Now', trello_identifier: '57269578b0dfecc6d11f84ce', priority: 4}.with_indifferent_access
  LM_MARKETING = {name: 'LM Marketing', trello_identifier: '572191a5b0dfecc6d11481aa', priority: 3}.with_indifferent_access
  LM_LEAD = {name: 'LM Lead', trello_identifier: '564e6a4119ad3a5dc235de8b', priority: 2}.with_indifferent_access
  OTHER = {name: 'Other', trello_identifier: '', priority: 1}.with_indifferent_access

  ALL = [MILLI, HOME_NOW, LM_MARKETING, LM_LEAD, OTHER]

  DIVIDER = ' | '

  class << self

    def find_by_trello_identifier(trello_identifier)
      ALL.select{|label| label['trello_identifier'] == trello_identifier}.first || OTHER
    end

    def find_by_name(name)
      ALL.select{|label| label['name'] == name}.first || OTHER
    end

    def to_field(labels)
      divider = ' | '
      labels.uniq.compact.map{|label| label['name']}.join(divider)
    end

    def top_label(labels_in_string)
      label_names = labels_in_string.split(DIVIDER)

      label_names.reduce(OTHER) do|top_priority_label, label_name|
        label = Label.find_by_name(label_name)

        top_priority_label['priority'] < label['priority'] ? label : top_priority_label
      end
    end
  end
end
