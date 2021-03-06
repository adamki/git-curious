class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    user = find_or_create_by(uid: auth[:uid])

    user.update_attributes(
      nickname:    auth.info.nickname,
      oauth_token: auth.credentials.token,
      email:       auth.info.email,
      image_url:   auth.info.image,
    )
    user
  end
end

