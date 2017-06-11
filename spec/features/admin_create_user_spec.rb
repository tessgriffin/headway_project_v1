require 'rails_helper'

feature 'Admin create new user' do
  scenario 'without admin privileges' do
    user = create(:user)

    sign_in(user.email, user.password)
    visit new_admin_user_path

    expect(page).to have_content('You must be an admin to perform that action')
  end

  scenario 'with admin privileges no roles' do
    user = create(:user, :admin)

    sign_in(user.email, user.password)
    visit new_admin_user_path

    expect(page).to have_content("New User")

    page.fill_in('First name', with: 'Bob')
    page.fill_in('Last name', with: 'Jones')
    page.fill_in('Email', with: 'test@example.com')
    page.fill_in('user[password]', with: 'me123456')
    page.fill_in('user[password_confirmation]', with: 'me123456')

    page.click_on('Create User')

    expect(page).to have_content('Listing Users')
    expect(page).to have_content('Bob')
  end

  scenario 'with admin privileges multiple roles' do
    user = create(:user, :admin)

    sign_in(user.email, user.password)
    visit new_admin_user_path

    expect(page).to have_content("New User")

    page.fill_in('First name', with: 'Bob')
    page.fill_in('Last name', with: 'Jones')
    page.fill_in('Email', with: 'test@example.com')
    page.check('user_roles_admin')
    page.check('user_roles_teacher')
    page.fill_in('user[password]', with: 'me123456')
    page.fill_in('user[password_confirmation]', with: 'me123456')

    page.click_on('Create User')

    expect(page).to have_content('Listing Users')
    expect(page).to have_content('Bob')
    expect(page).to have_content('admin')
    expect(page).to have_content('teacher')
  end
end