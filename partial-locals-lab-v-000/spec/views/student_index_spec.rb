
require "rails_helper"

RSpec.describe "Student" do
  describe 'search' do
    let(:student_names) { ['Bob', 'Robert', 'Roberta', 'Shirley', 'Shelby'] }

    before do
      student_names.each do |name|
        Student.create(name: name, hometown: Faker::Address.city, birthday: Faker::Date.between(25.years.ago, 18.years.ago))
      end
    end

    context 'when it receives a search query' do
      it 'returns all students whose names contain the given string' do
        view.lookup_context.prefixes = %w[students]
        assign(:students, Student.search('rob'))
        render :template => "students/index.html.erb"
        expect(rendered).to match /Roberta/
      end

      it 'renders the results with a partial' do
        view.lookup_context.prefixes = %w[students]
        assign(:students, Student.search('rob'))
        render :template => "students/index.html.erb"
        expect(rendered).to render_template(:partial => "student", locals: {student: Student.search('rob').first})
      end
    end
  end
end
