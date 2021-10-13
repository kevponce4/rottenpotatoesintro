class Movie < ActiveRecord::Base
   # https://fast-beach-15236.herokuapp.com/ 
  def self.all_ratings 
    ['G','PG','PG-13','R']
  end
end
