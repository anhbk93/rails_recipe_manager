class RecipesController < ApplicationController
  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 2)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.first
    if @recipe.save
      flash.now[:success] = "Your recipe was created successfully!"
      redirect_to recipes_path
    else
      # flash[:danger] = "Invalid information!"
      render :new
    end
  end

  def destroy
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash.now[:success] = "Your recipe was updated successfully!"
      redirect_to @recipe
    else
      render :edit
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def like
    @recipe = Recipe.find(params[:id])
    like = Like.create(like: params[:like], chef: Chef.first, recipe: @recipe)
    if like.valid?
      flash[:success] = "Your selection was successful!"
    else
      flash[:danger] = "Your can only like/dislike a crecipe once"
    end
    redirect_to :back
  end
  private
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end
end