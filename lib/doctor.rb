class Doctor
  attr_reader(:id, :specialty)
  attr_accessor(:name)

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
      id = doctor.fetch("id")
      doctors.push(Doctor.new({:specialty => specialty, :name => name, :id => nil}))
    end
    doctors
  end

  #doctor.save()
  def save
    result = DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@specialty}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end
