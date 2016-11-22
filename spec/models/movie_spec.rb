require 'rails_helper'

require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

RSpec.describe Movie, type: :model do
  describe 'Find Movies With Same Director' do
    movies_data = [
        {:title => 'Hulk', :director => 'Ang Lee', :rating => 'PG-13', :release_date => '2003-06-20'},
        {:title => 'Life of Pi', :director => 'Ang Lee', :rating => 'PG', :release_date => '2012-11-22'},
        {:title => 'The Dark Knight', :director => 'Christopher Nolan', :rating => 'PG-13', :release_date => '2008-07-18'},
        {:title => 'First Blood', :director => '', :rating => 'R', :release_date => '1982-10-22'}
    ]

    before :all do
      DatabaseCleaner.clean
      movies_data.each do |movie|
        Movie.create! movie
      end
    end

    context 'the specified movie has director information' do
      it 'should find movies with same director' do
        movies = Movie.find_by_director('Ang Lee')
        expect(movies.length).to eq 2
      end
    end

    context 'the specified movie has no director information' do
      it 'should not find any movies, but return nil' do
        movies = Movie.find_by_director(nil)
        expect(movies).to be_nil
      end
    end

    context 'a director has no movies at Rotten Potatoes yet' do
      it 'should not find any movies, but return an empty array' do
        movies = Movie.find_by_director('Director from Mars')
        expect(movies).not_to be_nil
        expect(movies.length).to eq(0)
      end
    end
  end
end
