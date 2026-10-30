class Consultation < ActiveRecord::Base
  # Chaque consultation relie un patient à un médecin grâce aux clés étrangères.
  belongs_to :patient, optional: false
  belongs_to :doctor, optional: false
end
