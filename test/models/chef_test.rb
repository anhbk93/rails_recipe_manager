require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.new(
                      chefname: "Anh NV",
                      email: "navait93@gmail.com"
                      )
  end

  test "chef should be valid" do
    assert @chef.valid?
  end

  test "chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "chefname should not be too long" do
    @chef.chefname = "a" * 51
    assert_not @chef.valid?
  end

  test "chefname should not be too short" do
    @chef.chefname = "a"
    assert_not @chef.valid?
  end

  test "email should not be too long" do
    @chef.email = "a" * 254 + "@mail.com"
    assert_not @chef.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[chef@example.com chef@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @chef.email = valid_address
      assert @chef.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[chef@example,com chef_at_foo.org chef.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @chef.email = invalid_address
      assert_not @chef.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email should be unique" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @chef.email = mixed_case_email
    @chef.save
    assert_equal mixed_case_email.downcase, @chef.reload.email
  end
end