require "test_helper"

class Admin::ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_projects_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_projects_edit_url
    assert_response :success
  end

  test "should get new" do
    get admin_projects_new_url
    assert_response :success
  end
end
