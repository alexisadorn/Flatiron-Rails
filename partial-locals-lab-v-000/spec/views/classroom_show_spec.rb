require "rails_helper"

RSpec.describe "classroom_show_view" do
  let(:classroom) { Classroom.create(course_name: 'Math', semester: "Spring #{Time.now.year}") }
  let(:student){ Student.create(name: 'Bobby', hometown: Faker::Address.city, birthday: Faker::Date.between(25.years.ago, 18.years.ago)) }

  before do
    5.times do
      Student.create(name: Faker::Name.name, hometown: Faker::Address.city, birthday: Faker::Date.between(25.years.ago, 18.years.ago))
    end
    Student.all.each do |student|
      ClassroomStudent.create(student: student, classroom: classroom)
    end
  end

  it "renders classroom information on the show view" do
    view.lookup_context.prefixes = %w[students, classrooms]
    student = Student.create(name: 'Bobby', hometown: Faker::Address.city, birthday: Faker::Date.between(25.years.ago, 18.years.ago))
    assign(:classroom, classroom)
    render :template => "classrooms/show.html.erb"
    expect(rendered).to match /Math/
  end

  it 'renders a partial that only contains classroom (not student) information' do
    view.lookup_context.prefixes = %w[students]
    assign(:classroom, classroom)
    render :partial => "classrooms/classroom.html.erb", locals: {classroom: classroom}
    expect(rendered).to match /Math/
  end

  it "renders a students/student partial" do
    view.lookup_context.prefixes = %w[students, classrooms]
    assign(:classroom, classroom)
    render :template => "classrooms/show.html.erb"
    expect(rendered).to render_template(:partial => "students/_student")
  end

  it "displays the student information from the partial" do
    view.lookup_context.prefixes = %w[students, classrooms]
    assign(:classroom, classroom)
    render :template => "classrooms/show.html.erb"
    expect(classroom.students.count).to eq 5
    classroom.students.each do |student|
      expect(rendered).to include(student.name)
    end
  end
end
