class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]

  def index
    @users = send_request('api/admins', hash, 'get')['data']
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if user_person_update
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :show }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def new; end

  def create; end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    user_param_array = if params[:user][:password]
                         %i[email member_level password password_confirmation]
                       else
                         %i[email member_level]
                       end
    params.require(:user).permit(user_param_array)
  end

  def person_hash
    {
      first_name: params[:user][:first_name],
      last_name: params[:user][:last_name]
    }
  end

  def user_person_update
    @user.person.update(person_hash) && @user.update(user_params)
  end
end
