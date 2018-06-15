require 'rails_helper'

describe 'Patient' do

  before do
    @patient = Patient.create(name: "Russell Wilson", age: 27)
    @mcdreamy = Doctor.create(name: "Derek Shepherd", department: "Neurosurgery")
    @meredith = Doctor.create(name: "Meredith Grey", department: "Internal Medicine")
    @appointment1 = Appointment.create(appointment_datetime: DateTime.new(2016, 10, 1), doctor: @mcdreamy, patient: @patient  )
    @appointment2 = Appointment.create(appointment_datetime: DateTime.new(2016, 10, 1), doctor: @meredith, patient: @patient  )
  end

  it 'has a name' do
    expect(@patient.name).to eq("Russell Wilson")
  end

  it 'has an age' do
    expect(@patient.age).to eq(27)
  end

  it 'has many appointments' do
    expect(@patient.appointments).to eq([@appointment1, @appointment2])
  end

  it 'has many doctors, through appointments' do
    expect(@patient.doctors).to eq([@mcdreamy, @meredith])
  end
end
