class Patient
  attr_reader :id
  attr_accessor :name, :dob, :doc_id, :id

  def initialize(patient)
    @name = patient.fetch(:name)
    @dob = patient.fetch(:dob)
    @doc_id = patient.fetch(:doc_id)
    @id = patient.fetch(:id)
  end

  def self.all
    returned_patients = DB.exec("SELECT * FROM patients;")
     patients = []
     returned_patients.each() do |patient|
       name = patient.fetch("name")
       dob = patient.fetch("dob")
       doc_id = patient.fetch("doc_id").to_i
       id = patient.fetch("id").to_i
       patients.push(Patient.new({:name => name, :dob => dob, :doc_id => doc_id, :id => id}))
     end
     patients
  end

  def save
    result = DB.exec("INSERT INTO patients (name, dob, doc_id) VALUES ('#{@name}', '#{@dob}', #{@doc_id}) RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def ==(another_patient)
    (self.name==another_patient.name).&(self.dob.==another_patient.dob).&(self.doc_id.==another_patient.doc_id)
  end


end
