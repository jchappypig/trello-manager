namespace :db do
  desc 'Save the cards for previous sprint'
  task save_previous: :environment do
    Syncer.save_previous(Sprint.last.number - 1)
  end

end
