class ApplicationController < ActionController::Base
   # 現在のユーザーを取得するメソッドをヘルパーメソッドとして使用可能にする
   helper_method :current_user, :user_signed_in?

   # 現在のユーザーを取得
   def current_user
     # セッションに保存されたユーザーIDをもとに、現在のユーザーを取得
     @current_user ||= User.find_by(id: session[:user_id])
   end

   # ユーザーがログインしているかどうかを判定
   def user_signed_in?
     current_user.present?
   end

   # ログインが必要なアクションで使用するフィルタ
   def require_login
     unless user_signed_in?
       redirect_to new_user_path, alert: 'ログインしてください'
     end
   end
end
