class CurrentCard < Card
  scope :done, -> { where(list: 'Current Sprint Done') }
end
