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
        expect(Doctor.all()).to(eq([]))
      end
  end

  describe("#==") do
    it("is the same task if it has the same description") do
      doctor1 = Doctor.new({:name => "name", :specialty => "specialty", :id => nil})
      doctor2 = Doctor.new({:name => "name", :specialty => "specialty", :id => nil})
      expect(doctor1).to(eq(doctor2))
    end
  end

  describe("#name") do
    it("tells you doctor name") do
      doctor_name = Doctor.new({:name => "name", :specialty => "specialty", :id => nil})
      expect(Doctor.name()).to(eq([doctor_name])
    end
  end

  

  describe("#save") do
    it("adds to the array of saved info from doctor database") do
      test_doctors = Doctor.new({:name => "name", :specialty => "specialty", :id => nil})
      test_doctors.save()
      expect(Doctor.all).to(eq([test_doctors]))
    end
  end
end
