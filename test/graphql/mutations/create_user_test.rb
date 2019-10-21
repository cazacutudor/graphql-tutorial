require 'test_helper'

class Mutations::CreateUserTest < ActiveSupport::TestCase
  def perform(args = {})
    Mutations::CreateUser.new(object: nil, context: {}).resolve(args)
  end

  test 'create new user' do
    user = perform(
       name: 'Gigi joa',
       auth_provider: {
           email: {
               email: "gigijoa@asd.com",
               password: "12345"
           }
       }
    )

    assert user.persisted?
    assert_equal user.name, "Gigi joa"
    assert_equal user.email, "gigijoa@asd.com"
  end
end