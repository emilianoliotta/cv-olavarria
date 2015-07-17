class ContactMailer < ActionMailer::Base
  default from: "\"CV Olavarria\" <compra.venta.olav@gmail.com>",
  		  charset: "UTF-8"

  def contacto_email(name, email, message)
    set_variables(name, email, message)

    mail(to: "liotta.emiliano@gmail.com",
    	 subject: "Consulta - CV Olavarria"
    	 )
  end

  def oferta_email(bid, email, owner_email, product, price)
    @bid = bid
    @email = email
    @owner_email = owner_email
    @product = product
    @price = price

    mail(to: @owner_email,
       subject: "CV Olavarria - Nueva oferta!"
       )

  end


  private

  def set_variables(name, email, message)
  	@name = name
  	@email = email
  	@message = message
  end

end
 