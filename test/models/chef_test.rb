require 'test_helper'

class ChefTest <ActiveSupport::TestCase

    def setup
        @chef = Chef.new(chefname: "Fredrick", email: "fredieondieki@yahoo.com")
    end
     test "should be valid" do
         assert @chef.valid?
     end

     test "chef name should be present" do
         @chef.chefname = " "
         assert_not @chef.valid?
     end

     test "Name should be less than 30 Characters" do
         @chef.chefname = "a" * 31
         assert_not @chef.valid?
     end
     test "Email should be present" do
         @chef.email = " "
         assert_not @chef.valid?
     end
     test "Email should not be too long" do
         @chef.email = "a" * 245 + "@example.com"
         assert_not @chef.valid?
 end
     test "Email should accept valid format" do
         valid_emails = %w[user@example.com fredieondieki@gmail.com F.first@yahoo.ca fredrick+ondieki@co.ke.org]
         valid_emails.each do |valids|
             @chef.email = valids
             assert @chef.valid?, "#{valids.inspect} should be valid"
         end
 end
 test "should reject invalid email addresses" do
     invalid_emails = %w[fredrick@example ondieki@example,com fredrick.name@gmail. joe@bar+foo.com]
    invalid_emails.each do |invalids|
      @chef.email = invalids
      assert_not @chef.valid?, "#{invalids.inspect} should be invalid"
  end
 end
 test "Email should be unique and case insensitive" do
     duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
 end
 test "Email should be lowecase before hitting the database" do
  mixed_email = "JohN@ExampLe.com"
  @chef.email = mixed_email
  @chef.save
  assert_equal mixed_email.downcase, @chef.reload.email
 end
end
