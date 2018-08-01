class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def build_name(google_response)
    name_parts = google_response['info']['name'].split(' ')
    first_name = name_parts.shift
    last_name = name_parts.join(' ')
    name_hash(first_name, last_name)
  end

  def name_hash(first_name, last_name)
    {
      first_name: first_name,
      last_name: last_name
    }
  end

  def user_params(google_response, person)
    person_id = person.id
    email = google_response['info']['email']

    user_hash(email, person_id)
  end
  
  def user_hash(email, person_id)
    {
      email: email,
      person_id: person_id,
      password: Devise.friendly_token[0, 20]
    }
  end
end
