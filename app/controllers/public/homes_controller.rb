class Public::HomesController < ApplicationController
  def top
    @edsc=Item.order("id DESC")
    @item=@edsc.first(4)
  end

  def about
  end
end
