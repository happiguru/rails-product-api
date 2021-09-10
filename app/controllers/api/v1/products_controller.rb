class Api::V1::ProductsController < ApplicationController
  def index
    products = Product.all
    render json: JSON.pretty_generate(JSON.parse(products.to_json))
  end

  def create
    product = Product.new(
      name: prod_params[:name],
      brand: prod_params[:brand],
      price: prod_params[:price],
      description: prod_params[:description]
    )
    if product.save
      render json: JSON.pretty_generate(JSON.parse(products.to_json))
    else
      render json: JSON.pretty_generate({error: "Error creating review."})
    end
  end

  def show
    product = Product.find_by(id: params[:id])
    if product
      render json: JSON.pretty_generate(JSON.parse(product.to_json)), status: 200
    else
      render json: JSON.pretty_generate({error: "Product not found"})
    end
  end

  private
    def prod_params
      params.require(:product).permit([
        :name,
        :brand,
        :price,
        :description
      ])
    end
end
