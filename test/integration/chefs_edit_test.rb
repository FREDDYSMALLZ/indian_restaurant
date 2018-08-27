require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "fredrick",
                      email: "fredieondieki@outlook.com",
                          password: "Welcome123",
                          password_confirmation: "Welcome123")
  end
  test "reject an invalid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: " ",
                              email: "fredieondieki@outlook.com" } }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "accept valid signup" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "fredrick1",
                                email: "fredieondieki@yahoo.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "fredrick1", @chef.chefname
    assert_match "fredieondieki@yahoo.com", @chef.email
  end
end
