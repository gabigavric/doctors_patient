require('rspec')
require('pg')
require('doctor')
require('spec_helper')

DB = PG.connect({:dbname=> 'admin_database_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
  end
end

describe(Doctor) do

  describe(".all") do
      it("is empty at first") do
        expect(Doctor.all).to(eq([]))
      end
  end

  describe("#==") do
    it("is the same doctor if they have the same everything") do
      doctor1 = Doctor.new({:name => "John", :specialty => "Pediatrics", :id => nil})
      doctor2 = Doctor.new({:name => "John", :specialty => "Pediatrics", :id => nil})
      expect(doctor1).to(eq(doctor2))
    end
  end

  describe("#save") do
    it("save new doctor to database") do
      doctor = Doctor.new({:name => "John", :specialty => "Pediatrics", :id => nil})
      doctor.save()
      expect(Doctor.all).to(eq([doctor]))
    end
  end

  describe("#name") do
    it("tell you doctor name") do
      doctor = Doctor.new({:name => "John", :specialty => "Pediatrics" , :id => nil})
      expect(doctor.name).to(eq("John"))
    end
  end

  describe("#specialty") do
    it("tell you doctors specialty") do
      doctor = Doctor.new({:name => "John", :specialty => "Pediatrics", :id => nil})
      expect(doctor.specialty).to(eq("Pediatrics"))
    end
  end

  describe("#id") do
      it("give ID to doctor when it is saved") do
        doctor = Doctor.new({:name => "John", :specialty => "Pediatrics", :id => nil})
        doctor.save()
        expect(doctor.id).to(be_an_instance_of(Fixnum))
      end
  end

  describe("#patients") do
   it("returns an array of patients for that doctor") do
     test_doctor = Doctor.new({name:"John", :specialty => "Pediatrics", :id => nil})
     test_doctor.save()
     test_patient1 = Patient.new({name:"John", dob: "1960-05-18", doc_id: test_doctor.id, :id => nil})
     test_patient1.save()
     test_patient2 = Patient.new({name:"John", dob: "1960-05-18", doc_id: test_doctor.id, :id => nil})
     test_patient2.save()
     expect(test_doctor.patients()).to(eq([test_patient1, test_patient2]))
   end
 end

 describe(".find") do
   it("returns a doctor by its ID") do
     test_doctor = Doctor.new({name:"John", :specialty => "Pediatrics", id: nil})
     test_doctor.save()
     test_doctor2 = Doctor.new({name:"John", :specialty => "Pediatrics", id: nil})
     test_doctor2.save()
     expect(Doctor.find(test_doctor2.id)).to(eq(test_doctor2))
   end
 end

end
