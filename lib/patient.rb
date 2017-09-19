class Patient
  attr_reader :id
  attr_accessor :name, :dob, :doctors_id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @dob = attributes.fetch(:dob)
    @doctors_id = attributes.fetch(:doctors_id)
  end

  def self.all()
    returned_patients = DB.exec("SELECT * FROM patients;")
     patients = []
     returned_patients.each() do |patient|
       name = patient.fetch("name")
       dob = patient.fetch("dob")
       doctors_id = patient.fetch("doctors_id")
       patients.push(Patient.new({:name => name, :dob => "dob", :doctors_id => doctors_id}))
     end
     patients
  end

  def ==(another_patient)
    (self.name==another_patient.name).&(self.dob.==another_patient.dob).&(self.doctors_id.==another_patient.doctors_id)
  end


  def save
    DB.exec("INSERT INTO patients (name, dob, doctors_id) VALUES ('#{@name}', '#{@dob}', #{@doctors_id}) RETURNING id;")
  end

end
