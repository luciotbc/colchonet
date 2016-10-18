class ApplicationController < ActionController::Base
  delegate :current_user, :user_signed_in?, to: :user_session
  protect_from_forgery

  before_filter :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
  def user_session
    UserSession.new(session)
  end
end
