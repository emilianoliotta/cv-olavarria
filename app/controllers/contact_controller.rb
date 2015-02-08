class ContactController < ApplicationController
  
  def index
  end

  def enviar
  	
    ContactMailer.contacto_email(params[:name], params[:email], params[:message]).deliver
    flash[:notice] = "Gracias por contactarse con nosotros."
    redirect_to welcome_index_path
  end

  def oferta
  	ContactMailer.oferta_email(params[:bid], params[:email], params[:owner_email], params[:product], params[:price]).deliver
    flash[:notice] = "El dueño del producto recibió su oferta/consulta. Gracias."
    redirect_to welcome_index_path
    
  end

end
