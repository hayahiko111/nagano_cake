class Admin::GenresController < ApplicationController
  def index
    @genre=Genre.new
    @genres=Genre.all
  end

  def create
    @genre=Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "You have created genre successfully."
      redirect_to admin_genres_path
    else
      render:index
    end
  end

  def edit
    @genre=Genre.find(params[:id])
  end

  def update
    @genre=Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "You have updated genre successfully."
      redirect_to admin_genres_path(@genre.id)
    else
      render:edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end