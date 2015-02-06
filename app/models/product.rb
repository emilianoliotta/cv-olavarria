class Product < ActiveRecord::Base
	belongs_to :user

	scope :by_title, -> sentido { order(title: (((sentido.present?) and (sentido.to_s.downcase == "asc")) ? :asc : :desc))}
	scope :by_created_at, -> sentido { order(created_at: (((sentido.present?) and (sentido.to_s.downcase == "asc")) ? :asc : :desc))}
	scope :by_price, -> sentido { order(price: (((sentido.present?) and (sentido.to_s.downcase == "asc")) ? :asc : :desc))}


	validates :title, :description, :allow_blank => false, :allow_nil => false, :on => :create, presence: true
	
	def self.search(query)
		consulta1 = where('products.title ilike ? or products.description ilike ?', "%#{query}%", "%#{query}%")
		arr = consulta1 # #MODIFICADO#Devuelve la unión de los dos conjuntos, pero es un arreglo, NO ES UNA ActiveRecord Relation
		return where(id: arr.map(&:id)) #Conversión a AR Relation... no es lo mejor pero así permite usar scopes
	end

	def self.greater_than(column, date)
		where("? > ?", column, date)
	end

	def self.less_than(column, date)
		where("? > ?", column, date)
	end

	# Permite obtener los productos cuyo valor en la columna especificada en column se
	# encuentre entre td1 y td2. Tener en cuenta que el orden de éstos importa, por lo
	# general, td1 debe ser mayor, en el sentido del tipo de datos, que td2, por ejemplo
	# si se desea buscar entre dos DateTimes, td1 debe ser anterior a td2.
	def self.between(column, td1, td2)
		where("#{column} BETWEEN ? AND ?", td1, td2)
	end

end
