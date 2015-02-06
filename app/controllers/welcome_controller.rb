class WelcomeController < ApplicationController
before_action :normalize, only: [:index]

  def index
  	if params[:search]
  		@products = Product.search(params[:search])
  	else
  		@products = Product.all
    end

  	if params[:sort_by].blank? == false
  		case params[:sort_by]
	  		when "title"
	  			@products = @products.by_title(params[:order])
	  		when "created_at"
	  			@products = @products.by_created_at(params[:order])
        when "price"
          @products = @products.by_price(params[:order])
  		end
  	elsif params[:order].blank? == false
  		@products = @products.by_created_at(params[:order])
  	else
  		@products = @products.by_created_at("desc")
  	end
  end

private

  def normalize
  	if params[:sort_by].blank? == false
  		params[:sort_by] = params[:sort_by].downcase.strip
  		puts params[:sort_by] != "title"
  		if params[:sort_by] != "title" and params[:sort_by] != "created_at" and params[:sort_by] != "price"
  			params[:sort_by] = "title"
  		end
  	end

  	if params[:order].blank? == false
  		params[:order] = params[:order].downcase.strip
  		if params[:order] != "asc" and params[:order] != "desc"
  			params[:order] = "asc"
  		end
  	end
  end
end
