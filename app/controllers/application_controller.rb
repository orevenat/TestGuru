class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def default_url_options
    I18n.locale == I18n.default_locale ? {} : { lang: I18n.locale }
  end

  protected

  def after_sign_in_path_for(resource)
    flash[:notice] = "Hello, #{current_user.full_name}"
    if resource.admin?
      admin_root_path
    else
      super
    end
  end

  def configure_permitted_parameters
    added_attrs = %i[first_name last_name email password password_confirmation
                     remember_me]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end

  def set_locale
    # I18n.locale = params[:lang] || I18n.default_locale
    I18n.locale = I18n.locale_available?(params[:lang]) ? params[:lang] : I18n.default_locale
  end
end
