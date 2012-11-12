class Plan < ActiveRecord::Base
  validates_presence_of :name, :price, :downloads_per, :genre, :max_downloads
  validates :downloads_per, :inclusion => { 
    :in => %w(month year), 
    :message => "must be 'year' or 'month"
  }
  validates :genre, :inclusion => { 
    :in => ['A la Carte', 'Annual Subscription'], 
    :message => "must be 'A la Carte' or 'Annual Subscription"
  }

end
