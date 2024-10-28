class ApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job_offer, only: [ :new, :create ]

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(user: current_user, job_offer: @job_offer)
    if @application.save
      UserMailer.application_notification(@application).deliver_now # Envía el correo a Esteban
      redirect_to job_offer_path(@job_offer), notice: "Te has postulado exitosamente."
    else
      flash.now[:alert] = @application.errors.full_messages.to_sentence # Muestra los errores
      render :new
    end
  end

  def index
    @applications = current_user.applications.includes(:job_offer) # Cargar las postulaciones del usuario actual
  end

  private

  def set_job_offer
    @job_offer = JobOffer.find(params[:job_offer_id])
  end
end
