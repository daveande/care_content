class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :role, :hospital_id

  validates :hospital_id, :presence => true

  belongs_to :hospital 
  has_many :downloads
  has_many :purchases

  def valid_purchases
    self.purchases.where('period_end > ? AND expired = ?', Time.now(), false)
  end

end
