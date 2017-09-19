require 'spec_helper'

DB = PG.connect({:dbname => 'admin_database_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM patients *;")
  end
end

describe(Patient) do

  describe("#save") do
    it("adds to the array of saved info from patient database") do
      test_patients = Patient.new({:name => "name", :dob => "dob", :doctors_id => "doctors_id" :id => nil})
      test_patients.save()
      expect(Patient.all).to(eq([test_patients]))
    end
  end

  describe(.all)
    it("starts off with no patients") do
      list_of_patients = []
      Patient.all.each do |patient|
        list_of_patients.push(patient)
      end
      expect(Patient.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds to the array of saved info from patient database") do
      test_patients = Patient.new({:name => "name", :specialty => "specialty", :id => nil})
      test_patients.save()
      expect(Patient.all).to(eq([test_patients]))
    end
  end
end

  # describe("#patients_id") do
  #   it("sets its ID when you save it") do
  #     list = List.new({:name => "Epicodus stuff", :id => nil})
  #     list.save()
  #     expect(list.id()).to(be_an_instance_of(Fixnum))
  #   end
  # end

end

#   describe("#dob") do
#     it("lets you savepatients date of birth") do
#       list = List.new({:name => "Epicodus stuff", :id => nil})
#       list.save()
#       expect(List.all()).to(eq([list]))
#     end
#   end
#
#   describe("#==") do
#     it("is the same task if it has the same description") do
#       patient1 = Patient.new({:name => "name", :dob => "dob", :id => nil})
#       patient2 = Patient.new({:name => "name", :dob => "dob", :id => nil})
#       expect(patient1).to(eq(patient2))
#     end
#   end
# end
