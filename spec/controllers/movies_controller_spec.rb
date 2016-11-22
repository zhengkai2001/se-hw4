require 'rails_helper'

require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

RSpec.describe MoviesController, type: :controller do
  movies_data = [
      {:title => 'Star Wars', :rating => 'PG', :director => 'George Lucas', :release_date => '1977-05-25'},
      {:title => 'Blade Runner', :rating => 'PG', :director => 'Ridley Scott', :release_date => '1982-06-25'},
      {:title => 'Alien', :rating => 'R', :director => '', :release_date => '1979-05-25'},
      {:title => 'THX-1138', :rating => 'R', :director => 'George Lucas', :release_date => '1971-03-11'}
  ]

  before :all do
    DatabaseCleaner.clean
    movies_data.each do |movie|
      Movie.create! movie
    end
  end

  render_views

  describe 'Browse in Rotten Potatoes' do
    context 'visit the home page of Rotten Potatoes' do
      it 'should display the home page' do
        get :index

        expect(response).to render_template(:index)
        expect(response.status).to eq(200)

        expect(response.body).to match(/Star Wars/)
        expect(response.body).to match(/Blade Runner/)
        expect(response.body).to match(/Alien/)
        expect(response.body).to match(/THX-1138/)
      end
    end

    context 'visit the details page of a movie' do
      it 'should display the details page of a movie' do
        get :show, :id => 1

        expect(response).to render_template(:show)
        expect(response.status).to eq(200)

        expect(response.body).to match(/Star Wars/)
        expect(response.body).not_to match(/Blade Runner/)
        expect(response.body).not_to match(/Alien/)
        expect(response.body).not_to match(/THX-1138/)
      end
    end

    context 'add a new movie' do
      it 'should add a new movie using given information' do
        get :index
        expect(response.body).not_to match(/Raiders of the Lost Ark/)

        post :create, :movie => {
            :title => 'Raiders of the Lost Ark', :director => 'George Lucas',
            :rating => 'PG', :release_date => '1981-06-12'}

        get :index
        expect(response.body).to match(/Raiders of the Lost Ark/)
      end
    end

    context 'delete a movie' do
      it 'should delete a movie using given id' do
        get :index
        expect(response.body).to match(/Star Wars/)

        delete :destroy, :id => 1

        get :index
        expect(response.body).to match(/Star Wars/)
      end
    end

    context 'update a movie' do
      it "should update a movie's information" do
        get :index
        expect(response.body).to match(/Star Wars/)
        expect(response.body).not_to match(/Star Wars: Episode IV - A New Hope/)

        post :update, :id => 1, :movie => {
            :title => 'Star Wars: Episode IV - A New Hope', :director => 'George Lucas',
            :rating => 'PG', :release_date => '1977-05-25'}

        get :index
        expect(response.body).to match(/Star Wars: Episode IV - A New Hope/)
      end
    end
  end

  describe 'Find movies with same director' do
    context 'the specified movie has director information' do
      it 'should find movies with same director' do
        get :director_all_movies, :director => 'George Lucas'

        expect(response).to render_template(:director_all_movies)
        expect(response.status).to eq(200)

        expect(response.body).to match(/Star Wars/)
        expect(response.body).to match(/THX-1138/)
        expect(response.body).not_to match(/Blade Runner/)
        expect(response.body).not_to match(/Alien/)
      end
    end

    context 'the specified movie has no director information' do
      it 'should not find any movies' do
        get :director_all_movies, :director => nil

        expect(response).to render_template(:director_all_movies)
        expect(response.status).to eq(200)

        expect(response.body).to match(/Please enter a valid director./)
      end
    end
  end
end
