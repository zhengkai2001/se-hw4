class MoviesController < ApplicationController
  def initialize
    @all_ratings = Movie.all_ratings
    @rating_selected = @all_ratings.map { |rating| [rating, true] }.to_h
    super
  end

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all

    if params[:ratings]
      ratings = params[:ratings].keys
    elsif session[:filter]
      ratings = session[:filter]
    else
      ratings = nil
    end

    if params[:sort_by]
      sort_by = params[:sort_by]
    elsif session[:sort_by]
      sort_by = session[:sort_by]
    else
      sort_by = nil
    end

    if ratings
      @movies.where!(rating: ratings)
      @all_ratings.each do |rating|
        @rating_selected[rating] = ratings.include? rating
      end
      session[:filter] = ratings
    end

    if sort_by == 'title' || sort_by == 'release_date'
      @movies.order!(sort_by)
      session[:sort_by] = sort_by
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

end
