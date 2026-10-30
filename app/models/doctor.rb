class Doctor < ActiveRecord::Base
  has_many :interns
  has_many :consultations
  # through permet de retrouver les patients via leurs consultations.
  has_many :patients, through: :consultations

  # Une validation empêche l'enregistrement si le prénom est vide.
  validates :first_name, presence: true
end
