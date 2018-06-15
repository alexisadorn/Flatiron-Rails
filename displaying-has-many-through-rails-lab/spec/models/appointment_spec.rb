require 'rails_helper'

describe 'Appointment' do

  before do
    @mcdreamy = Doctor.create(name: "Derek Shepherd", department: "Neurosurgery")
    @patient = Patient.create(name: "Russell Wilson", age: 27)
    @appointment = Appointment.create({appointment_datetime: DateTime.new(2016, 12, 25), patient: @patient, doctor: @mcdreamy})
  end

  it 'has a date and time' do
    expect(@appointment.appointment_datetime.strftime('%B %d, %Y')).to eq('December 25, 2016')
  end

  it 'belongs to a patient' do
    expect(@appointment.doctor).to be(@mcdreamy)
  end

  it 'belongs to a doctor' do
    expect(@appointment.patient).to be(@patient)
  end

end
