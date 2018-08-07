class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :first_name, :last_name, :mobile_number
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  belongs_to :person
  enum member_level: %i[guest employee manager company_admin super_admin]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      person = Person.find_or_create_by(first_name: auth["info"]["first_name"], last_name: auth["info"]["last_name"])
      user.person_id = person.id
      user.provider = auth.provider
      user.uid = auth.uid
      user.image = auth.info.image
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.save!
    end
  end
end
