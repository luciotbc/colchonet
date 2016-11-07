class ApplicationController < ActionController::Base
  delegate :current_user, :user_signed_in?, to: :user_session
  helper_method :current_user, :user_signed_in?

  protect_from_forgery

  before_action :set_locale

  #Locale config
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def user_session
    UserSession.new(session)
  end

  #Authentication filters
  def require_authentication
    unless user_signed_in?
      redirect_to new_user_sessions_path,
      :alert => t('flash.alert.needs_login')
    end
  end

  def require_no_authentication
    redirect_to root_path if user_signed_in?
  end

end
