require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test 'gets created, assigns omniauth auth data to @auth' do
    auth = {      
      here: 'is',
      some: 'auth',
      data: '.',
      provider: 'facebook',
    }
    @request.env['omniauth.auth'] = auth
    get :create
    assert assigns(:auth) == auth
  end
end
