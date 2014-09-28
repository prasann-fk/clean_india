class User < ActiveRecord::Base
  has_many :user_providers

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  def self.from_omniauth(auth)
    provider = UserProvider.where(provider: auth.provider, uid: auth.uid).first
    return provider.user if provider
    user = where(email: auth.info.email).first
    user = User.create!(:email => auth.info.email, :password => Devise.friendly_token[0,20]) if user.nil?
    user.user_providers.create!(provider: auth.provider, uid: auth.uid)
    user.name = auth.info.name
    user.image = auth.info.image
    user
  end

end
