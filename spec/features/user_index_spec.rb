require 'rails_helper'
RSpec.describe 'User Index Page', type: :feature do
  before(:each) do
    @users = [
      @user1 = User.create(
        name: 'Ruby',
        photo: 'https://avatars.githubusercontent.com/u/112550568?v=4',
        bio: 'C# Developer from India.',
        posts_counter: 6
      ),
      @user2 = User.create(
        name: 'Diana Beki',
        photo: 'https://avatars.githubusercontent.com/u/99320947?v=4',
        bio: 'Software developer from Kenya',
        posts_counter: 0
      )
    ]
    visit users_url
  end

  it 'can see the username of all other users' do
    @users.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  it 'can see the profile picture for each user' do
    @users.each do |user|
      expect(page).to have_css("img[src*='#{user.photo}']")
    end
  end

  it 'can see the number of posts each user has written' do
    @users.each do |user|
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end
  end

  it 'redirects to user show page when clicked on a user' do
    click_link(@users[0].name)
    expect(page).to have_current_path(user_path(@users[0].id))
  end
end
