class RegistrationsController < Devise::RegistrationsController
  before_action :build_person, only: :create
  respond_to :html, :js

  def new
    super
  end

  def create
    if @person.save
      @user = User.new(sign_up_params.merge(person_id: @person.id))
      if @user.save
        redirect_success!
      else
        @error = @user.errors.full_messages.first
      end
    else
      @error = @person.errors.full_messages.first
    end
  end

  private

  def build_person
    @person = Person.new(name_params)
  end

  def name_params
    {
      first_name: params[:user][:first_name],
      last_name: params[:user][:last_name]
    }
  end

  def redirect_success!
    flash[:success] = 'User has been created'
    redirect_to unauthenticated_root_path
  end
end
