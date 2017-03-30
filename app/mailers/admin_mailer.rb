class AdminMailer < ApplicationMailer
  default to: 'w.eleventh@gmail.com', from: 'depot_app'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.exception_occured.subject
  #
  def exception_occured(exception)
    @exception = exception
    mail subject: "Exception Occured During Running"
  end
end
