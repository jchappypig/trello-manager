# Scaffolding generated by Casein v5.1.1.5

module Casein
  class CardsController < Casein::CaseinController
    before_filter :sync_trello, only: [:index, :completed]


    ## optional filters for defining usage according to Casein::AdminUser access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]

    def index
      @casein_page_title = 'Current all'

      calculate_cards(CurrentCard.all)
    end

    def completed
      @casein_page_title = 'Current completed'

      calculate_cards(CurrentCard.done)

      render :index
    end

    def previous_completed
      sprints_ago = params[:sprints_ago] || 1
      sprint = Sprint.which(Time.now.utc - sprints_ago.to_i*2.weeks)
      @casein_page_title = "Previous completed (#{sprint.start} - #{sprint.finish})"

      calculate_cards(HistoricalCard.where(sprint: sprint))

      render :index
    end

    def export
      cards = Card.where(id: params[:ids] || [])
      respond_to do |format|
        format.csv { send_data Exporter.cards_to_csv(cards), filename: "cards-#{Time.now}.csv" }
      end
    end

    def show
      @casein_page_title = 'View card'
      @card = Card.find params[:id]
    end

    private
    def sync_trello
      current_sprint_has_no_card = !CurrentCard.any?
      if current_sprint_has_no_card || (CurrentCard.last.created_at < Time.now - 15.minutes)
        CurrentCard.delete_all unless current_sprint_has_no_card
        trello_cards = Trello::Action.search('board:"Awesome one team" list:"current" is:open', cards_limit: 200)['cards'] +
            Trello::Action.search('board:"Awesome one team" list:"pull" is:open', cards_limit: 200)['cards'] +
            Trello::Action.search('board:"Awesome one team" list:"work in progress" closed:false is:open', cards_limit: 200)['cards'] +
            Trello::Action.search('board:"Awesome one team" list:"up next" is:open', cards_limit: 200)['cards']


        Syncer.mass_from_trello(trello_cards)
      end
    end

    def calculate_cards(scope)
      @cards, @points = {}, {}
      labels = Label::ALL.map { |label| label['name'] }

      labels.each do |label|
        @cards[label] = scope.with_top_label(label)
        @points[label] = @cards[label].map(&:estimated_size).sum
      end

      @cards['Total'] = labels.reduce([]) { |total_cards, label| total_cards + @cards[label] }
      @points['Total'] = labels.reduce(0) { |total_points, label| total_points + @points[label] }
    end

  end
end