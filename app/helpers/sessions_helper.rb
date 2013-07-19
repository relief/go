module SessionsHelper
   public
	def sign_in(user , set_cookie)
		# 1 for permanent cookie, 0 for temporary cookie, 2 for no change to the cookie(used when update)
		if set_cookie.to_s == "1".to_s
		   cookies.permanent[:remember_token] = user.remember_token 
		else
		   cookies[:remember_token] = user.remember_token
		end
   		self.current_user = user			
	end
	def signed_in?
		!current_user.nil?
	end
	def current_user= (user)
		@current_user = user
	end
	def current_user
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
	end
	def current_user?(user)
		user == current_user
	end
	def signed_in_user
		unless signed_in?
			store_location
			redirect_to signin_url, notice: "Please sign in."
		end
	end
	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end
	def store_location
		session[:return_to] = request.url
	end
end
