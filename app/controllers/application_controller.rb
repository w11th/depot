class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # rescue_from Exception, with: :mail_exception_to_admin
  before_action :authorize
  before_action :set_i18n_locale_from_params

  protected

  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def authorize
    if request.format == Mime[:html]
      redirect_to login_url, notice: 'Please log in' unless User.find_by(id: session[:user_id])
    else
      authenticate_or_request_with_http_basic do |username, password|
        head 401 unless User.authenticate(username, password)
      end
    end
  end

  private

  def mail_exception_to_admin(exception)
    logger.error "Exception: #{exception} occured in application"
    AdminMailer.exception_occured(exception).deliver_later
  end

  # before_action :set_local

  # def set_local
  #   I18n.locale = request.headers['Accept-Language']
  #   locals = I18n.available_locales
  #   I18n.local = http_accept_language.compatible_language_from(locales)
  # end
end
