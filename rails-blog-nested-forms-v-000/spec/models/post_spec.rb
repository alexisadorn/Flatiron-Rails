require 'spec_helper'

describe Post do
  describe 'validations' do
    describe 'tags_attributes' do
      it 'rejects tags_attributes if :name is blank' do
        expect {
          Post.create(
            name: 'post',
            content: 'post',
            tags_attributes: [
              {}
            ]
          )
        }.not_to change(Tag, :count)
      end
    end

    describe 'post_attributes' do
      it 'rejects the post if :name is blank' do
        expect {
          Post.create!(content: 'content')
        }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'rejects the post if :content is blank' do
        expect {
          Post.create!(name: 'name')
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
