class ApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job_offer, only: [ :new, :create ]

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(user: current_user, job_offer: @job_offer)
    if @application.save
      # Enviar notificación a Esteban (puedes usar ActionMailer)
      redirect_to job_offer_path(@job_offer), notice: "Te has postulado exitosamente."
    else
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
