class Intern < ActiveRecord::Base
  # belongs_to utilise doctor_id, stocké dans la table interns.
  # Sans Rails, optional: false rend explicitement le médecin obligatoire.
  belongs_to :doctor, optional: false
end
