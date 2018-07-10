class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    person = Person.new(build_name)
    return unless person.save
    @user = User.new(sign_up_params.merge(person_id: person.id))
    if @user.save
      flash[:success] = 'User has been created'
      redirect_to unauthenticated_root_path
    else
      @error = @user.errors.full_messages.first
    end
  end

  private

  def build_name
    name_parts = params[:user][:name].split(' ')
    {
      first_name: name_parts[0],
      last_name: name_parts.drop(1).join(' ')
    }
  end
end
