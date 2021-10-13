class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    @ratings_to_show = []
    @title_style ="bg-white hilite"
    @release_date_style = "bg-white hilite"
    if params[:ratings].nil?
      @ratings_to_show = @all_ratings
    else
      @ratings_to_show = params[:ratings].keys
    @ratings = params[:ratings]
    end
    @order = ""
    if params[:sort] == "title"
      @order = :title
      @title_style = "bg-warning hilite"
      @release_date_style = "bg-white hilite"
    elsif params[:sort] == "release_date"
      @order = :release_date
      @release_date_style = "bg-warning hilite"
      @title_style = "bg-white hilite"
    end
    @movies = Movie.where(:rating => @ratings_to_show).order params[:sort]
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

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
