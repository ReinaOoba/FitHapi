class ApplicationController < ActionController::Base
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
        root_path
    elsif resource_or_scope == :admin
        new_admin_session_path
    else
        root_path
    end
  end

  def reject_customer
    @user = User.find_by(name: params[:user][:email])
    if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == false)
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
      redirect_to new_user_registration
    end
  end

end
