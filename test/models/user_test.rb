require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # run using 'bundle exec rake test'
  

	# tests whether @user is a valid user (will return true because we created @user in setup method)
  def setup
    # WE WILL BE USING THIS USER THAT WE SETUP THROUGHOUT OUR TESTS
    @user = User.new(name: "Example User", email: "user@example.com")
  end
  test "should be valid" do
  	# will return TRUE because @user IS a valid instance of the model User
    assert @user.valid?
  end


  # tests whether name and email is present before saving in the database
  test "name should be present" do
    @user.name = "     "
    # will return FALSE because @user.name is not equal to "     "
    # after validation in user.rb model is added, will now return TRUE
    assert_not @user.valid?
  end
  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end


  # tests whether name and email are too long
  # will return false until validation is added to user.rb (set maximum characters)
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end



  # accepts email addresses that are valid, as stated in the user model
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  # add regex to user model in order to get this test to pass
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  # checking for unique email addresses in the database:
  # The method here is to make a user with the same email address as @user using @user.dup, which creates a duplicate user with the same attributes. Since we then save @user, the duplicate user has an email address that already exists in the database, and hence should not be valid.
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  # There’s just one small problem, which is that the Active Record uniqueness validation does not guarantee uniqueness at the database level. Here’s a scenario that explains why:

  # Alice signs up for the sample app, with address alice@wonderland.com.
  # Alice accidentally clicks on “Submit” twice, sending two requests in quick succession.
  # The following sequence occurs: request 1 creates a user in memory that passes validation, request 2 does the same, request 1’s user gets saved, request 2’s user gets saved.
  # Result: two user records with the exact same email address, despite the uniqueness validation
  # If the above sequence seems implausible, believe me, it isn’t: it can happen on any Rails website with significant traffic (which I once learned the hard way). Luckily, the solution is straightforward to implement: we just need to enforce uniqueness at the database level as well as at the model level. Our method is to create a database index on the email column (Box 6.2), and then require that the index be unique.




end