class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    everything("facebook")
  end

  def google_oauth2
    everything("google")
  end

  def everything(provider)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => provider.capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end