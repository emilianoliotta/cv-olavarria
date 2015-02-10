class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:create,:update,:destroy,:index]
  before_action :product_context, only: [:show, :update]

  def index
    @products = Product.where(user_id: current_user.id)
  end

  def show
  end

  def edit
  end

  def new
    # Crea un nuevo producto en blanco al entrar a la vista para publicar un nuevo producto
    # Éste servirá para caracterizar el formulario en la vista
    @product = Product.new
  end

  def create
    title = params[:product][:title]
    imgURL = params[:product][:imageURL]
    description = params[:product][:description]
    price = params[:product][:price]

    fecha_creado = Time.now

    # A la variable anteriormente creada le asigno el nuevo producto
    @product = Product.create(title: title, description: description, imageURL: imgURL, price: price, user: current_user, created_at: fecha_creado)

    if @product.errors.any?
      flash.now[:alert] = view_context.generate_html_error(@product)
    else
      flash[:notice] = "Producto publicado. En caso de haber ofertas, recibirá un email."
      redirect_to products_path(@product)
    end
  end

  def update
    @temp = false
    
    if params[:product].blank? or params[:product][:chosen_bid_id].blank?
      flash.now[:alert] = "No se ha elegido ninguna oferta."
      render :show
      return false
    end

    bid_id = params[:product][:chosen_bid_id].to_i
    chosen_bid =  Bid.find(bid_id)
    
    if @product.timeout? and not @product.finished? and current_user == @owner and chosen_bid.present? and chosen_bid.product == @product
      @product.chosen_bid = chosen_bid
      @product.finished_at = Time.now
      @product.save

      if @product.errors.any?
        flash.now[:alert] = view_context.generate_html_error(@product)
        render :show
      else
        UserMailer.bid_accepted_seller_email(chosen_bid).deliver
        UserMailer.bid_accepted_buyer_email(chosen_bid).deliver
        render :bid_finished
      end
    else
      html = <<-HTML
      <div id="error_explanation">
        <h4>Error al actualizar la oferta ganadora del producto. Se puede deber a:</h4>
        <ul>
          <li>El usuario que esta actualizando la oferta no es creador de la subasta</li>
          <li>La oferta considerada como ganadora no existe</li>
          <li>La oferta considerada como ganadora en realidad corresponde a otro producto</li>
          <li>Todavía no terminó el tiempo para hacer subastas</li>
          <li>Ya se ha elegido una oferta ganadora</li>
        </ul>
      </div>
      HTML
      flash.now[:alert] = html.html_safe
      render :update
    end

    
  end

  def destroy
    @product = current_user.products.find(params[:id])
    @product.destroy
    flash[:notice] = "Producto eliminado."
    redirect_to products_path
  end

  private

  def product_context
    @product = Product.find(params[:id])
    @owner = @product.user
  end
end
