class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 R NC-17)
  end

  def self.find_by_director(director)
    if director != nil
      Movie.where(:director => director)
    end
  end
end
