class CreateInterns < ActiveRecord::Migration[8.1]
  def change
    create_table :interns do |t|
      t.string :first_name
      t.string :last_name
      # Crée doctor_id, son index et une contrainte vers la table doctors.
      t.references :doctor, foreign_key: true
      t.timestamps
    end
  end
end
