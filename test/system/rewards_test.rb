require "application_system_test_case"

class RewardsTest < ApplicationSystemTestCase
  setup do
    @reward = rewards(:one)
  end

  test "visiting the index" do
    visit rewards_url
    assert_selector "h1", text: "Rewards"
  end

  test "creating a Reward" do
    visit rewards_url
    click_on "New Reward"

    fill_in "Content", with: @reward.content
    fill_in "Description", with: @reward.description
    fill_in "Title", with: @reward.title
    fill_in "User", with: @reward.user_id
    click_on "Create Reward"

    assert_text "Reward was successfully created"
    click_on "Back"
  end

  test "updating a Reward" do
    visit rewards_url
    click_on "Edit", match: :first

    fill_in "Content", with: @reward.content
    fill_in "Description", with: @reward.description
    fill_in "Title", with: @reward.title
    fill_in "User", with: @reward.user_id
    click_on "Update Reward"

    assert_text "Reward was successfully updated"
    click_on "Back"
  end

  test "destroying a Reward" do
    visit rewards_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Reward was successfully destroyed"
  end
end
