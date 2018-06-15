require "rails_helper"

RSpec.describe "show_view" do
  let(:classroom) { Classroom.create(course_name: 'Math', semester: "Spring #{Time.now.year}") }
  let(:oldest_student) { Student.create(name: "Grandpa",
                        hometown: Faker::Address.city,
                        birthday: Faker::Date.between(30.years.ago, 29.years.ago)) }

  before do
    5.times do
      Student.create(name: Faker::Name.name, hometown: Faker::Address.city, birthday: Faker::Date.between(25.years.ago, 18.years.ago))
    end
    Student.all.each do |student|
      ClassroomStudent.create(student: student, classroom: classroom)
    end
      ClassroomStudent.create(student: oldest_student, classroom: classroom)
  end

  it "renders student information from the classrooms show view" do
    view.lookup_context.prefixes = %w[students]
    assign(:classroom, classroom)
    assign(:student, classroom.oldest_student)
    render :template => "classrooms/show.html.erb"
    expect(rendered).to match /Grandpa/
  end

  it "renders a students/student partial" do
    view.lookup_context.prefixes = %w[students]
    assign(:classroom, classroom)
    assign(:student, classroom.oldest_student)
    render :template => "classrooms/show.html.erb"
    expect(rendered).to render_template(:partial => "students/_student")
  end

  it "displays the student information from the student partial" do
    view.lookup_context.prefixes = %w[students]
    assign(:student, classroom.oldest_student)
    render :partial => "students/student.html.erb"
    expect(rendered).to match /Grandpa/
  end

  it "displays the student information from students the partial" do
    view.lookup_context.prefixes = %w[students]
    assign(:student, classroom.oldest_student)
    render :template => "students/show.html.erb"
    expect(rendered).to render_template(:partial => "students/_student")
  end
end
