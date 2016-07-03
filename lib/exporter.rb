require 'csv'

class Exporter
  class << self
    def cards_to_csv(cards)
      attributes = %w{name estimated_size status project on_sprint sprint_start sprint_finish}

      CSV.generate(headers: true) do |csv|
        csv << attributes

        cards.each do |card|
          name = card.name
          estimated_size = card.estimated_size
          status = TrelloList.to_status(card)
          project = card.labels
          sprint = card.sprint
          on_sprint = sprint.number
          sprint_start = sprint.start
          sprint_finish = sprint.finish
          csv << [name, estimated_size, status, project, on_sprint, sprint_start, sprint_finish]
        end
      end
    end
  end
end