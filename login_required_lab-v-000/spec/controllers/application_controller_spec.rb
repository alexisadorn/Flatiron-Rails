require 'rails_helper'

RSpec.describe ApplicationController do
  describe 'current_user' do
    it 'returns the name of the current user' do
      i_am = 'Kate Libby'
      @request.session[:name] = i_am
      expect(subject.current_user).to eq i_am
    end

    it 'returns nil if nobody is logged in' do
      expect(subject.current_user).to be nil
    end
  end
end
