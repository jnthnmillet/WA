class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  belongs_to :person

  def self.from_omniauth(auth, person)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      return unless person.save
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.image = auth.info.image
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.person_id = person.id
      user.save!
    end
  end
end
