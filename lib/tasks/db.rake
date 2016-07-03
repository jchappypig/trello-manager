namespace :db do
  desc 'Save the cards for previous sprint'
  task save_previous: :environment do
    Syncer.save_previous
  end

end
