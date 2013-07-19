class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,	 only: :destroy
  def index
  	@users = User.paginate(page: params[:page])
  end
  def new
	@user = User.new
  end
  def show
	@user = User.find(params[:id])
	@microposts = @user.microposts.paginate(page: params[:page])
  end
  def create
	@user = User.new(user_params)
	if @user.save
		# Handle a successful save
		sign_in @user, "0"
		flash[:success] = "Welcome to our new world!"
		redirect_to @user
	else
		render 'new'
	end
  end
  def edit
	@user = User.find(params[:id])
  end
  def update
	@user = User.find(params[:id])
	if @user.update_attributes(params[:user])
		flash[:success] = "Profile updated"
		sign_in @user, "2"
		redirect_to @user
	else
		render 'edit'
	end
  end
  def destroy
     
	@tem_user = User.find(params[:id])
        @tem_user.destroy
	flash[:success] = "User " + @tem_user.name +  " has been destroyed." 
        redirect_to users_url
  end
  private
    def correct_user
	@user = User.find(params[:id])
	redirect_to(root_path) unless current_user?(@user)
    end	
  private   
    def admin_user
	redirect_to(root_path) unless current_user.admin?
    end
  private 
    def user_params
	params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
