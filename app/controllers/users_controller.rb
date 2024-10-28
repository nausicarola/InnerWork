class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin!, only: [ :new, :create ]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "Usuario creado exitosamente."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Usuario actualizado exitosamente."
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: "Usuario eliminado exitosamente."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def applications
    @applications = current_user.applications.includes(:job_offer)
  end

  def check_admin!
    redirect_to root_path, alert: "No tienes permiso para realizar esta acción." unless current_user.admin?
  end
end
