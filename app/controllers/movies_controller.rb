class MoviesController < ApplicationController
  def self.sortable_attributes;
    %w(title release_date director rating)
  end

  def initialize
    @all_ratings = Movie.all_ratings
    @rating_selected = @all_ratings.map { |rating| [rating, true] }.to_h
    super
  end

  def movie_params
    params.require(:movie).permit(:title, :director, :rating, :description, :release_date)
  end

  def show
    id = params[:id]
    @movie = Movie.find(id)
    @director = @movie.director
  end

  def index
    @movies = Movie.all
    filter
    sort
  end

  def filter
    if params[:ratings]
      ratings = params[:ratings].keys
    elsif session[:filter]
      ratings = session[:filter]
    else
      ratings = nil
    end

    if ratings
      @movies.where!(rating: ratings)
      @all_ratings.each do |rating|
        @rating_selected[rating] = ratings.include? rating
      end
      session[:filter] = ratings
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  # add in hw4
  def same_director
    if params[:director]
      @director = params[:director]
      @movies = Movie.find_by_director(@director)
      sort
    else
      @director = nil
    end

    if params[:from]
      @from_movie_id = params[:from]
      @from_movie = Movie.find(@from_movie_id)
    else
      @from_movie_id = nil
    end
  end

  def sort
    if params[:sort_by]
      sort_by = params[:sort_by]
    elsif session[:sort_by]
      sort_by = session[:sort_by]
    else
      sort_by = nil
    end

    if self.class.sortable_attributes.include?(sort_by)
      @movies.order!(sort_by)
      session[:sort_by] = sort_by
    end
  end
end
