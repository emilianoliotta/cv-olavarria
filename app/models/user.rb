class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, :allow_blank => false, :allow_nil => false, :on => :create, presence: true
  
  has_many :products, dependent: :destroy
end
