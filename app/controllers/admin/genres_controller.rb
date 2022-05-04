class Admin::GenresController < ApplicationController
  def index
    @genre=Admin::Genre.new
    @genres=Admin::Genre.all
  end

  def create
    @genre=Admin::Genre.new(genre_params)
    if @genre=Admin::Genre.save
      flash[:notice] = "You have created genre successfully."
      redirect_to admin_genre_path
    else
      render:index
    end
  end

  def edit
    @genre=Admin::Genre.find(params[:id])
  end

  def update
    @genre=Admin::Genre.find(params[:id])
    @genre.admin_id = current_admin.id
    if @genre.update(genre_params)
      flash[:notice] = "You have updated genre successfully."
      redirect_to book_path(@book.id)
    else
      render:edit
    end
  end

  private

  def genre_params
    params.require(:admingenre).permit(:name)
  end
end
