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
    person = Person.new(build_name)
    return unless person.save
    @user = User.new(sign_up_params.merge(person_id: person.id))

    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted? || @user.save
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def build_name
    auth = request.env['omniauth.auth']
    name_parts = auth['info']['name'].split(' ')
    {
      first_name: name_parts[0],
      last_name: name_parts.drop(1).join(' ')
    }
  end
end
