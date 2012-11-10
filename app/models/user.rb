class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :restaurants

  def api_data
    {
      :email => email,
    }
  end

  def generate_table_token!
    begin
      table_token = SecureRandom.urlsafe_base64
    end while User.where(:table_token => table_token).exists?
    self.update_attribute(:table_token, table_token)
  end
end
