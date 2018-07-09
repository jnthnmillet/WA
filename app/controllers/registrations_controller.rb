class RegistrationsController < Devise::RegistrationsController
<<<<<<< HEAD
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
=======

>>>>>>> Make registration alert work
  def new
    super
  end

<<<<<<< HEAD
  # def show
  #   super
  # end
  # POST /resource

  def create
    # binding.pry
    @user = User.new(sign_up_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to unauthenticated_root_path, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end 
  end

  private

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
=======
  def create
    @user = User.new(sign_up_params)
      if @user.save
        flash[:success] = "User has been created"
        redirect_to unauthenticated_root_path
      else
        @error = @user.errors.full_messages.first
      end
  end
end
>>>>>>> Make registration alert work
