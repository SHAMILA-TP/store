class ProductsController < ApplicationController

  before_action :set_product, only:[:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def show
    @product
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product
  end

  def update
    if @product.update product_params
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
   if @product.destroy
     redirect_to products_path
   end
  end


  def product_params
    params.require(:product).permit(:name, :photo, :inventory_count)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
