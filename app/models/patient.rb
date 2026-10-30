class Patient < ActiveRecord::Base
  has_many :consultations
  # La table consultations relie les patients à leurs médecins.
  has_many :doctors, through: :consultations
end
