require 'rails_helper'

describe "patients", type:  :feature do
  before do
    Doctor.create([
      {name: "Meredith Grey", department: "Internal Medicine"},
      {name: "Hawkeye Pierce", department: "Surgery"},
      {name: "Leonard 'Bones' McCoy", department: "Internal Medicine"},
      {name: "Phillip Chandler", department: "Internal Medicine"},
      {name: "Michaela Quinn", department: "Internal Medicine"}
    ])

    Patient.create([
      {name: "Homer Simpson", age:38},
      {name: "Bart Simpson", age:10},
      {name: "Marge Simpson", age:36},
      {name: "Lisa Simpson", age:8},
      {name: "Maggie Simpson", age:1},
    ])

    Appointment.create([
      {appointment_datetime: DateTime.new(2016, 03, 15, 18, 00, 0), patient_id: 1, doctor_id: 2},
      {appointment_datetime: DateTime.new(2016, 01, 11, 20, 20, 0), patient_id: 2, doctor_id: 1},
      {appointment_datetime: DateTime.new(2016, 04, 22, 14, 00, 0), patient_id: 3, doctor_id:5 },
      {appointment_datetime: DateTime.new(2017, 10, 30, 15, 00, 0), patient_id: 4, doctor_id:4 },
      {appointment_datetime: DateTime.new(2016, 07, 11, 16, 00, 0), patient_id: 5, doctor_id: 3},
      {appointment_datetime: DateTime.new(2016, 05, 31, 17, 00, 0), patient_id: 1, doctor_id: 2},
      {appointment_datetime: DateTime.new(2017, 06, 03, 10, 00, 0), patient_id: 3, doctor_id: 1}
      ])

      @meredith = Doctor.first
      @bart = Patient.find(2)
  end

  describe "#index page" do
    it 'lists all of the patients and the number of appointments they have' do
      visit patients_path
      within("ul") do
        expect(page).to have_content("Name: Marge Simpson Number of Appointments: 2")
        expect(page).to have_content("Name: Bart Simpson Number of Appointments: 1")
      end
    end
  end

  describe "#show page" do
    it "shows all of a patient's appointment times in a human readable format" do
      visit patient_path(@bart)
      expect(page).to have_content("January 11, 2016 at 20:20")
    end

    it "links to the doctor's show page by name for the doctor of each appointment" do
      visit patient_path(@bart)
      expect(page).to have_link("Meredith Grey", href: doctor_path(@meredith))
    end
  end

end
