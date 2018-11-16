class SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    user = send_request('api/login', login_hash, 'post')
    if user.present?
      login(user)
    else
      redirect_to new_user_session_path, alert: 'Invalid Username or Password'
    end
  end

  private

  def login_hash
    {
      username: params[:user][:email],
      password: params[:user][:password]
    }
  end

  def find_or_create_user(user)
    password = user[:access_token][0, 128]
    User.create_with(password: password, password_confirmation: password, person_id: user[:person_id]).find_or_create_by(email: user[:email])
  end

  def user_hash(user)
    {
      email: user['data']['profile']['email'],
      person_id: user['data']['profile']['id'],
      token_type: user['data']['token_type'],
      access_token: user['data']['access_token']
    }
  end

  def login(user)
    return redirect_to new_user_session_path, alert: 'Please verify your email first' if user['code'] == 400

    @user = find_or_create_user(user_hash(user))
    sign_in(@user)
    @user.update(token_type: user['data']['token_type'], access_token: user['data']['access_token'])
    redirect_to authenticated_root_path
  end
end
