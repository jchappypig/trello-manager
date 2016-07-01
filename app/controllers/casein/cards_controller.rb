# Scaffolding generated by Casein v5.1.1.5

module Casein
  class CardsController < Casein::CaseinController


    SIZE_MAP = {'s' => 1, 'S' => 1, 'm' => 3, 'M' => 3, 'l' => 5, 'L' => 5}

    ## optional filters for defining usage according to Casein::AdminUser access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]

    def index
      @casein_page_title = 'Current all'
      @cards = Trello::Action.search('board:"Awesome one team" list:"current" is:open', cards_limit: 200)['cards']
      @cards = @cards +  Trello::Action.search('board:"Awesome one team" list:"pull" is:open', cards_limit: 200)['cards']
      @cards = @cards +  Trello::Action.search('board:"Awesome one team" list:"work in progress" closed:false is:open', cards_limit: 200)['cards']
      @cards = @cards +  Trello::Action.search('board:"Awesome one team" list:"up next" is:open', cards_limit: 200)['cards']

      @points = calculate_points(@cards)
    end

    def completed
      @casein_page_title = 'Current completed'
      @cards = Trello::Action.search('board:"Awesome one team" list:"current" is:open', cards_limit: 200)['cards']

      @points = calculate_points(@cards)

      render :index
    end

    def show
      @casein_page_title = 'View card'
      @card = Card.find params[:id]
    end

    private

    def calculate_points(cards)
      points = {'Total' => 0, 'Milli' => 0, 'Home Now' => 0, 'LM Marketing' => 0, 'LM Lead' => 0, 'Other' => 0}

      cards.each do |card|
        size_match = /\[(s|m|l)\]/i.match(card.name)
        size = size_match.present? ? size_match[1] : 's'

        labels = card.card_labels

        points['Total'] = points['Total'] + SIZE_MAP[size]

        calculate_points_for_label(points, labels, size, 'Milli') ||
            calculate_points_for_label(points, labels, size, 'Home Now') ||
            calculate_points_for_label(points, labels, size, 'LM Marketing') ||
            calculate_points_for_label(points, labels, size, 'Other')
      end

      points
    end

    def calculate_points_for_label(points, labels, size, label_name)
      if label_is?(labels, label_name) || label_name == 'Other'
        points[label_name] = points[label_name] + SIZE_MAP[size]
      end
    end


    def label_is?(labels, label_name)
      labels.select { |label| label['name'] == label_name }.any?
    end

  end
end