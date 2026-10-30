class CreateDoctors < ActiveRecord::Migration[8.1]
  def change
    create_table :doctors do |t|
      t.string :first_name
      t.string :last_name
      t.timestamps # Ajoute les dates de création (created_at) et de modification (updated_at).
    end
  end
end
