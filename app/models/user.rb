class User < ActiveRecord::Base
  rolify
  devise :trackable, :omniauthable, omniauth_providers: [:github]

  has_many :topics, foreign_key: :student_id, dependent: :destroy

  def name
    return "unknown" if read_attribute(:name).nil?
    super
  end

  def self.from_omniauth(auth)
    user = where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.email = auth.info.email
      user.github_name = auth.info.nickname
      user.name = auth.info.name
      user.image = auth.info.image
    end
    if user.image != auth.info.image
      user.image = auth.info.image
      user.save
    end
    user

  end

end
