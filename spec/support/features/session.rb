module Features
  def sign_in
    sign_in_with(current_user.email, current_user.password)
  end

  def sign_in_with(email, password)
    visit sign_in_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Sign in'
  end

  def current_user
    @current_user ||= create(:user)
  end
end
