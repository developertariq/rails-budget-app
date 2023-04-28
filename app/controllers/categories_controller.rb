class CategoriesController < ApplicationController
  def index
    @user = current_user
    @categories = @user.categories.all
  end

  def new
    @category = Category.new
  end

  def create
    @user = current_user
    @category = @user.categories.new(category_params)

    if @category.save
      redirect_to categories_path, notice: 'Category created successfully.'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon.name, :author_id)
  end
end
