class JobOffersController < ApplicationController
  before_action :set_job_offer, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :check_admin!, only: [ :new, :create ]

  def index
    @job_offers = JobOffer.all
  end

  def show; end

  def new
    @job_offer = JobOffer.new
  end

  def create
    @job_offer = JobOffer.new(job_offer_params)
    @job_offer.user = current_user # Establecer el usuario que crea la oferta
    if @job_offer.save
      redirect_to @job_offer, notice: "Oferta laboral creada exitosamente."
    else
      render :new
    end
  end

  def update
    if @job_offer.update(job_offer_params)
      redirect_to @job_offer, notice: "Oferta laboral actualizada exitosamente."
    else
      render :edit
    end
  end

  def destroy
    @job_offer.destroy
    redirect_to job_offers_url, notice: "Oferta laboral eliminada exitosamente."
  end

  private

  def set_job_offer
    @job_offer = JobOffer.find(params[:id])
  end

  def job_offer_params
    params.require(:job_offer).permit(:title, :description)
  end

  def check_admin!
    redirect_to root_path, alert: "No tienes permiso para realizar esta acción." unless current_user.admin?
  end
end
