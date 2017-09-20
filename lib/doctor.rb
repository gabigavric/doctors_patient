class Doctor
  attr_reader :id, :specialty
  attr_accessor :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @specialty = attributes.fetch(:specialty)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctors = []
    returned_doctors.each() do |doctor|
      specialty = doctor.fetch("specialty")
      name = doctor.fetch("name")
      id = doctor.fetch("id").to_i
      doctors.push(Doctor.new({:name => name, :specialty => specialty, :id => id}))
    end
    doctors
  end

  def save
    result = DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@specialty}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(another_doctor)
   (self.name.==another_doctor.name).&(self.id.==another_doctor.id)
 end

 def patients
   doctor_patients = []
   patients = DB.exec("SELECT * FROM patients WHERE doc_id = #{self.id};")
   patients.each() do |patient|
     name = patient.fetch("name")
     dob = patient.fetch("dob")
     doc_id = patient.fetch("doc_id").to_i
     id = patient.fetch("id").to_i
     doctor_patients.push(Patient.new({name: name, dob: dob, doc_id: doc_id, id: id}))
   end
   doctor_patients
 end

 def self.find(id)
   found_doctor = nil
   Doctor.all().each() do |doctor|
     if doctor.id().==(id)
       found_doctor = doctor
     end
   end
   found_doctor
 end
end
