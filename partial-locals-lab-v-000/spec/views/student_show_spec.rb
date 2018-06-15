require "rails_helper"

RSpec.describe "show_view" do
  let(:student){ Student.create(name: 'Bobby', hometown: Faker::Address.city, birthday: Faker::Date.between(25.years.ago, 18.years.ago)) }

  it "renders student information from the classroom show view" do
    view.lookup_context.prefixes = %w[students]
    assign(:student, student)
    render :template => "students/show.html.erb"
    expect(rendered).to include('Bobby')
  end

  it "renders a students/student partial" do
    view.lookup_context.prefixes = %w[students]
    assign(:student, student)
    render :template => "students/show.html.erb"
    expect(rendered).to render_template(:partial => "student", locals: {student: student})
  end

  it "displays the student information from the partial" do
    assign(:student, student)
    render :partial => "students/student.html.erb", locals: {student: student}
    expect(rendered).to match /Bobby/
  end
end
