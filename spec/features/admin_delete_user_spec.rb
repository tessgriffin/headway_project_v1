require 'rails_helper'

feature 'Admin can delete users' do
  scenario 'with admin privileges' do
    admin = create(:user, :admin)
    user = create(:user)

    sign_in(admin.email, admin.password)
    visit admin_users_path


    page.find_link('Remove', href: "/admin/users/#{user.id}").click

    expect(page).not_to have_content("#{user.last_name}")
  end
end