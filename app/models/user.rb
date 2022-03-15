class User < ActiveRecord::Base

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :password, presence: true
  validates_length_of :password, minimum: 6, on: :create
  validates_presence_of :password_confirmation
  has_secure_password
  
  
  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase) unless email.nil?
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end

end