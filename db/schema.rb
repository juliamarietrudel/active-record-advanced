# Ce fichier est généré automatiquement à partir de la structure de la base.
# Pour modifier cette structure, créer une migration, puis régénérer le schéma.
# Conserver ce fichier dans le système de gestion de versions du projet.
# Une nouvelle génération peut rétablir les commentaires anglais d'Active Record.

ActiveRecord::Schema[8.1].define(version: 2026_10_30_093650) do
  create_table "consultations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "doctor_id"
    t.integer "patient_id"
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_consultations_on_doctor_id"
    t.index ["patient_id"], name: "index_consultations_on_patient_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.datetime "updated_at", null: false
  end

  create_table "interns", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "doctor_id"
    t.string "first_name"
    t.string "last_name"
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_interns_on_doctor_id"
  end

  create_table "patients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "consultations", "doctors"
  add_foreign_key "consultations", "patients"
  add_foreign_key "interns", "doctors"
end
