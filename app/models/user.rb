class User < ActiveRecord::Base
  devise :omniauthable, omniauth_providers: [:github]

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end
