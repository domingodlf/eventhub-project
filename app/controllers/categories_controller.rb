class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    authorize! :read, Category
    @categories = Category.all
  end

  def show
    authorize! :read, @category
  end

  def new
    @category = Category.new
    authorize! :create, @category
  end

  def create
    @category = Category.new(category_params)
    authorize! :create, @category

    if @category.save
      redirect_to @category, notice: "Category was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @category
  end

  def update
    authorize! :update, @category

    if @category.update(category_params)
      redirect_to @category, notice: "Category was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @category

    @category.destroy
    redirect_to categories_path, notice: "Category was successfully deleted."
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end