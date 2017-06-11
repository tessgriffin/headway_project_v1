require 'rails_helper'

feature 'Admin can edit users' do
  scenario 'with admin privileges' do
    admin = create(:user, :admin)
    user = create(:user)

    sign_in(admin.email, admin.password)
    visit admin_users_path


    page.find_link('Edit', href: "/admin/users/#{user.id}/edit").click

    page.fill_in('First name', with: 'Bob')
    page.check('user_roles_teacher')

    page.click_on('Update User')

    expect(page).to have_content('Listing Users')
    expect(page).to have_content('teacher')
    expect(page).to have_content('Bob')
    expect(page).not_to have_content("#{user.first_name}")
  end

  scenario 'can edit to remove roles' do
    admin = create(:user, :admin)
    teacher = create(:user, :teacher)

    sign_in(admin.email, admin.password)
    visit admin_users_path

    expect(page).to have_content('teacher')

    page.find_link('Edit', href: "/admin/users/#{teacher.id}/edit").click
    page.uncheck('user_roles_teacher')
    page.click_on('Update User')

    expect(page).to have_content('Listing Users')
    expect(page).not_to have_content('teacher')
  end
end