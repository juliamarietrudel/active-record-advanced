require_relative '../config/application'

# La base en mémoire protège les données du cours pendant les tests.
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Base.logger = nil
ActiveRecord::Migration.verbose = false
ActiveRecord::MigrationContext.new(File.expand_path('../db/migrate', __dir__)).migrate

RSpec.describe 'Les associations médicales' do
  around do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end

  it 'retrouve les patients du médecin et les médecins du patient' do
    doctor = Doctor.create!(first_name: 'Alice')
    patient = Patient.create!(first_name: 'Sam')
    Consultation.create!(doctor: doctor, patient: patient)

    expect(doctor.patients).to contain_exactly(patient)
    expect(patient.doctors).to contain_exactly(doctor)
  end

  it 'relie un interne à son médecin' do
    doctor = Doctor.create!(first_name: 'Alice')
    intern = Intern.create!(first_name: 'Alex', doctor: doctor)

    expect(intern.doctor).to eq(doctor)
    expect(doctor.interns).to contain_exactly(intern)
  end

  it 'refuse un médecin sans prénom' do
    expect(Doctor.new(first_name: ' ')).not_to be_valid
  end

  it 'refuse un interne sans médecin' do
    expect(Intern.new).not_to be_valid
  end

  it 'refuse une consultation sans patient ou sans médecin' do
    doctor = Doctor.create!(first_name: 'Alice')
    patient = Patient.create!(first_name: 'Sam')

    expect(Consultation.new(doctor: doctor)).not_to be_valid
    expect(Consultation.new(patient: patient)).not_to be_valid
  end
end
