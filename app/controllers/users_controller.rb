class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [:create]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    # get current user todos
    @users = User.all.paginate(page: params[:page], per_page: 20)
    json_response(@users)
  end

  # GET /users/:id
  def show
    json_response(@user)
  end

  # POST users/register
  # return authenticated token upon signup
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  # PUT /users/:id
  def update
    @user.update(user_params)
    head :no_content
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    head :no_content
  end

  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :id
    )
  end

  def set_user
    # TODO: maybe not done
    @user = User.find_by(email: params[:email])
  end
end
