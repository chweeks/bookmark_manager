feature 'User sign up' do

  let(:user){ build :user }

  scenario 'I can sign up as a new user' do
    expect { sign_up(user) }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'requires a matching confirmation password' do
    user = create(:user, password_confirmation: 'wrong')
    expect {sign_up(user)}.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario 'without an email address' do
    user = create(:user, email: nil)
    expect {sign_up(user)}.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Email must not be blank'
  end

  scenario 'I cannot sign up with an existing email' do
    sign_up(user)
    expect{ sign_up(user) }.to change(User, :count).by(0)
    expect(page).to have_content('Email is already taken')
  end
end

feature 'User sign in' do

  let(:user){ create :user }

  scenario 'with correct credentials' do
    sign_in(email: user.email, password: user.password)
    expect(page).to have_content "Welcome, #{user.email}"
  end
end


feature 'User signs out' do

  let(:user){ create :user }

  scenario 'while being signed in' do
    sign_in(email: user.email, password: user.password)
    click_button 'Sign out'
    expect(page).to have_content('goodbye!')
    expect(page).not_to have_content("Welcome, #{user.email}")
  end
end
