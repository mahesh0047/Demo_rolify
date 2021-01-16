# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # You should configure your model like this:
    # devise :omniauthable, omniauth_providers: [:twitter]

    # You should also create an action method in this controller like this:
    # def twitter
    # end

    # More info at:
    # https://github.com/heartcombo/devise#omniauth

    # GET|POST /resource/auth/twitter
    # def passthru
    #   super
    # end

    # GET|POST /users/auth/twitter/callback
    # def failure
    #   super
    # end

    # protected

    # The path used when OmniAuth fails
    # def after_omniauth_failure_path_for(scope)
    #   super(scope)
    # end
    # def google_oauth2
    #   user = User.from_google(from_google_params)

    #   if user.present?
    #     sign_out_all_scopes
    #     flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
    #     sign_in_and_redirect user, event: :authentication
    #   else
    #     flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
    #     redirect_to new_user_registration_url
    #   end
    # end

    def google_oauth2
      @user = User.create_from_provider_data(request.env['omniauth.auth'])
      if @user.persisted?
        sign_in_and_redirect @user
        set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
      else
        flash[:error] = 'There was a problem signing you in through Google. Please register or try signing in later.'
        redirect_to new_user_registration_url
      end
    end

    protected

    def after_omniauth_failure_path_for(_scope)
      new_user_registration_url
    end

    def after_sign_in_path_for(resource_or_scope)
      stored_location_for(resource_or_scope) || root_path
    end

    private

    def from_google_params
      @from_google_params ||= {
        uid: auth.uid,
        email: auth.info.email,
        full_name: auth.info.name,
        avatar_url: auth.info.image
      }
    end

    def auth
      @auth ||= request.env['omniauth.auth']
    end
  end
end
