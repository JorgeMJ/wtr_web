require "application_system_test_case"

class CustodiansTest < ApplicationSystemTestCase
  setup do
    @custodian = custodians(:one)
  end

  test "visiting the index" do
    visit custodians_url
    assert_selector "h1", text: "Custodians"
  end

  test "should create custodian" do
    visit custodians_url
    click_on "New custodian"

    click_on "Create Custodian"

    assert_text "Custodian was successfully created"
    click_on "Back"
  end

  test "should update Custodian" do
    visit custodian_url(@custodian)
    click_on "Edit this custodian", match: :first

    click_on "Update Custodian"

    assert_text "Custodian was successfully updated"
    click_on "Back"
  end

  test "should destroy Custodian" do
    visit custodian_url(@custodian)
    click_on "Destroy this custodian", match: :first

    assert_text "Custodian was successfully destroyed"
  end
end
