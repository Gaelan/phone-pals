require "application_system_test_case"

class CalleesTest < ApplicationSystemTestCase
  setup do
    @callee = callees(:one)
  end

  test "visiting the index" do
    visit callees_url
    assert_selector "h1", text: "Callees"
  end

  test "creating a Callee" do
    visit callees_url
    click_on "New Callee"

    fill_in "Bio", with: @callee.bio
    fill_in "First name", with: @callee.first_name
    fill_in "Last name", with: @callee.last_name
    click_on "Create Callee"

    assert_text "Callee was successfully created"
    click_on "Back"
  end

  test "updating a Callee" do
    visit callees_url
    click_on "Edit", match: :first

    fill_in "Bio", with: @callee.bio
    fill_in "First name", with: @callee.first_name
    fill_in "Last name", with: @callee.last_name
    click_on "Update Callee"

    assert_text "Callee was successfully updated"
    click_on "Back"
  end

  test "destroying a Callee" do
    visit callees_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Callee was successfully destroyed"
  end
end
