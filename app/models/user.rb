class User < ActiveRecord::Base
  devise :trackable, :omniauthable, omniauth_providers: [:github]

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.email = auth.info.email
      user.github_name = auth.info.nickname
      user.name = auth.info.name
      user.image = auth.info.image
    end
  end
end
