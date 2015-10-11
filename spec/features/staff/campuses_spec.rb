require 'rails_helper'

RSpec.feature "Campus instructor view", type: :feature do
  let!(:instructor) do
    create :instructor_user
  end

  feature 'Viewing campuses' do
    scenario 'with multiple available campuses' do
      campuses = create_list :campus, 5

      sign_in(instructor)
      visit(staff_campuses_path)

      expect(page).to have_content(campuses.first.name)
    end
  end

  scenario 'creating a campus' do
    sign_in(instructor)
    visit(new_staff_campus_path)

    fill_in 'Name', with: 'Nashville'
    click_button 'Create'

    expect(page).to have_content('Campus successfully created!')
  end
end
