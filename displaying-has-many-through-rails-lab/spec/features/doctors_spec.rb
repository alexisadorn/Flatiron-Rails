require 'rails_helper'

describe "doctors", type: :feature do
  before do
    @meredith = Doctor.create({name: "Meredith Grey", department: "Internal Medicine"})
    @bart = Patient.create(name: "Bart Simpson", age:10 )
    Appointment.create(appointment_datetime: DateTime.new(2016, 01, 11, 20, 20, 0), patient_id: 1, doctor_id: 1)
  end

  describe "#show page" do
    it "shows all of a doctor's appointment times in a human readable format" do
      visit doctor_path(@meredith)
      expect(page).to have_content("January 11, 2016 at 20:20")
    end

    it "links to the patient's show page by name for each appointment" do
      visit doctor_path(@meredith)
      expect(page).to have_link("Bart Simpson", href: patient_path(@bart))
    end
  end
end
