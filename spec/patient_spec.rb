require 'spec_helper'

DB = PG.connect({:dbname => 'admin_database_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM patients *;")
  end
end

describe(Patient) do

  describe(".all") do
    it("starts off with no patients") do
      expect(Patient.all).to(eq([]))
    end
  end

  describe("#name") do
   it("tell you patient name") do
     patient = Patient.new({name:"John", dob: "1960-05-18", doc_id: 1, id: nil})
     expect(patient.name).to(eq("John"))
    end
  end

  describe("#dob") do
    it("tell you patient birthday") do
      patient = Patient.new({name:"John", dob: "1960-05-18", doc_id: 1, id: nil})
      expect(patient.dob).to(eq("1960-05-18"))
      end
    end

  describe("#id") do
    it("set patient ID when you save it") do
     patient = Patient.new({name:"John", dob: "1960-05-18", doc_id: 1, id: nil})
     patient.save
     expect(patient.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("let you save a patient to the database") do
      patient = Patient.new({:name => "name", :dob => "1960-05-18", doc_id: 1 , :id => nil})
      patient.save
      expect(Patient.all).to(eq([patient]))
    end
  end

  describe("#==") do
      it("is the same patient if they have all of the same things") do
        patient1 = Patient.new({:name => "John", :dob => "1960-05-18", doc_id: 1, :id => nil})
        patient2 = Patient.new({:name => "John", :dob => "1960-05-18", doc_id: 1, :id => nil})
        expect(patient1).to(eq(patient2))
      end
    end

end
