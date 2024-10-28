class UserMailer < ApplicationMailer
  def application_notification(application)
    @application = application
    @job_offer = application.job_offer

    mail(to: "carola.pruebas.programa@gmail.com", subject: "Nueva Postulación Recibida")
  end
end
