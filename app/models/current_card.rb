class CurrentCard < Card
  scope :done, -> { where(list: 'Current Sprint done') }
end
