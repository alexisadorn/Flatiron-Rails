require 'rails_helper'

describe 'Doctor' do

  before do
    @mcdreamy = Doctor.create(name: "Derek Shepherd", department: "Neurosurgery")
    @patient1 = Patient.create(name: "Bill Gates", age: 60)
    @patient2 = Patient.create(name: "Russell Wilson", age: 27)
    @appointment1 = Appointment.create(appointment_datetime: DateTime.new(2016, 10, 1), doctor: @mcdreamy, patient: @patient1  )
    @appointment2 = Appointment.create(appointment_datetime: DateTime.new(2016, 10, 1), doctor: @mcdreamy, patient: @patient2  )
  end

  it 'has a name' do
    expect(@mcdreamy.name).to eq("Derek Shepherd")
  end

  it 'has a department' do
    expect(@mcdreamy.department).to eq("Neurosurgery")
  end

  it 'has many appointments' do
    expect(@mcdreamy.appointments).to eq([@appointment1, @appointment2])
  end

  it 'has many patients, through appointments' do
    expect(@mcdreamy.patients).to eq([@patient1, @patient2])
  end
end
