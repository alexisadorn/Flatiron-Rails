require 'spec_helper'

describe Tag do
  describe ":name" do
    it "should be unique" do
      expect {
        Tag.create(name: 'tag')
      }.to change(Tag, :count).by(1)

      expect{
        Tag.create!(name: 'tag')
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
