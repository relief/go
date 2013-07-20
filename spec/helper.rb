module Helpers
  def sign_in(user , set_cookie)
  3                 # 1 for permanent cookie, 0 for temporary cookie, 2 for no c    hange to the cookie(used when update)
  4                 if set_cookie.to_s == "1".to_s
  5                    cookies.permanent[:remember_token] = user.remember_token
  6                 else
  7                    cookies[:remember_token] = user.remember_token
  8                 end
  9                 self.current_user = user
 10         end

  def help
    :available
  end
end
