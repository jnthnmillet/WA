require 'test_helper'

class DeviseTest < ActionDispatch::IntegrationTest
  test 'should be able to see the login page' do
    get '/users/sign_in'
    assert_response 200
    assert_select 'legend.uk-legend', 'Login'
    assert_select 'legend.uk-legend', text: 'Register', count: 0
    assert_select 'input#user_email', count: 1
  end

  test 'should be able to see registration page' do
    get '/users/sign_up'
    assert_response 200
    assert_select 'p.alert', @error, count: 0
    assert_select 'label', 'Email'
    assert_select 'input#user_email', count: 1
    assert_select 'input#user_password', count: 1
    assert_select 'input#user_password_confirmation', count: 1
    assert_select 'input.uk-button', count: 1
  end

  test 'should be able to register successfully' do
    get '/users/sign_up'
    assert_response 200

    post '/users',
         params: {
           user: {
             first_name: 'Clay',
             last_name: 'Reyes',
             email: 'creyes@sample.com',
             password: 'password',
             password_confirmation: 'password'
           }
         }
    assert_response 302
    assert_equal Person.last.first_name, 'Clay'
    assert_equal Person.last.last_name, 'Reyes'
    assert_equal User.last.email, 'creyes@sample.com'
  end

  test 'should be able to see password reset page' do
    get '/users/password/new'
    assert_response 200

    assert_select 'label', 'Email'
    assert_select 'input#user_email', count: 1
    assert_select 'input.uk-button', count: 1
    assert_select 'a', 'Log in'
    assert_select 'a', 'Sign up'
  end
end
