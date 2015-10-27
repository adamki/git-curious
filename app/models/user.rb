class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    where(uid: auth[:uid]).first_or_create do |new_user|
      new_user.nickname           = auth.info.nickname
      new_user.uid                = auth.uid
      new_user.oauth_token        = auth.credentials.token
      new_user.email              = auth.info.email
      new_user.image_url          = auth.info.image
    end
  end
end
