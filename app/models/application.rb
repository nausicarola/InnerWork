class Application < ApplicationRecord
  belongs_to :user
  belongs_to :job_offer

    # Validación para evitar múltiples postulaciones a la misma oferta por el mismo usuario
    validates :user_id, uniqueness: { scope: :job_offer_id, message: "ya ha postulado a esta oferta." }
end
