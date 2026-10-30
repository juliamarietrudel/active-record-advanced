# Découvrir Active Record

Ce projet Ruby utilise Active Record sans Rails pour illustrer les migrations,
les validations et les associations à partir d'un cabinet médical.

## Installation

Avec Ruby 3.3.5 installé, exécuter depuis le dossier du projet :

```sh
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake console
```

`bundle exec rake -T` affiche les tâches disponibles. La configuration SQLite
se trouve dans `config/database.yml`. `db/schema.rb` est généré par les migrations :
pour modifier les tables, ajouter une migration dans `db/migrate`.

## Exemple dans la console

```ruby
doctor = Doctor.create!(first_name: 'Alice', last_name: 'Roy')
patient = Patient.create!(first_name: 'Sam', last_name: 'Gagnon')
intern = Intern.create!(first_name: 'Alex', doctor: doctor)
Consultation.create!(doctor: doctor, patient: patient)

doctor.interns    # Les internes encadrés par ce médecin
doctor.patients  # Les patients retrouvés via les consultations
patient.doctors  # Les médecins retrouvés via les consultations
intern.doctor    # Le médecin associé grâce à doctor_id

Doctor.new.valid? # false : le prénom est obligatoire
```

`create!` enregistre en base et lève une exception si les validations échouent.
`new` construit seulement un objet en mémoire. Les liens `belongs_to` sont
obligatoires ici ; les clés étrangères des migrations assurent que les références
non nulles désignent des enregistrements existants.

## Vérifications

```sh
bundle exec rspec
bundle exec rake db:version
```

Les tests exécutent les migrations dans une base SQLite en mémoire.
`APP_ENV=test bundle exec rake db:migrate` utilise plutôt `db/test.sqlite3`.
