class ContactController < ApplicationController
  
  def index
  end

  def enviar
  	
    ContactMailer.contacto_email(params[:name], params[:email], params[:message]).deliver
    flash[:notice] = "Gracias por contactarse con nosotros, hemos recibido su mensaje."
    redirect_to welcome_index_path
  end

  def oferta
  	ContactMailer.oferta_email(params[:bid], params[:email], params[:owner_email], params[:product], params[:price]).deliver
    flash[:notice] = "El dueño del producto recibirá un email con su oferta y se contactará con usted. Muchas gracias."
    redirect_to welcome_index_path
    
  end

end
