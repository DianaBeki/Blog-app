require 'rails_helper'

RSpec.describe 'posts#index', type: :feature do
  before(:each) do
    @user = User.create(
      name: 'Diana',
      photo: 'images/user.svg',
      bio: 'Web Developer',
      posts_counter: 0
    )

    @posts = [
      @post1 = Post.create(author: @user, title: 'User Post 1', text: 'This is User Post 1', likes_counter: 0,
                           comments_counter: 0),
      @post2 = Post.create(author: @user, title: 'User Post 2', text: 'This is User Post 2', likes_counter: 0,
                           comments_counter: 0),
      @post3 = Post.create(author: @user, title: 'User Post 3', text: 'This is User Post 3', likes_counter: 0,
                           comments_counter: 0)
    ]

    visit user_posts_url(user_id: @user.id)
  end

  describe '#index page' do
    before(:each) do
      visit "/users/#{@user.id}/posts"
    end
    it 'can see the user profile picture.' do
      expect(page).to have_css("img[src='#{@user.photo}']")
    end

    it 'can see the user username.' do
      expect(page).to have_content(@user.name.to_s)
    end

    it 'can see the number of posts the user has written.' do
      expect(page).to have_content(@user.posts_counter.to_s)
    end

    it 'can see posts title' do
      expect(page).to have_content 'User Post 1'
    end

    it 'can see some of the body of the post' do
      expect(page).to have_content 'This is User Post 1'
    end

    it 'can see the first comments on a post.' do
      @posts.each do |post|
        post.recent_comments.each do |comment|
          expect(page).to have_content(comment.user.text)
        end
      end
    end

    it 'can see how many comments a post has' do
      @posts.each do |post|
        expect(page).to have_content(post.comments_counter.to_s)
      end
    end

    it 'can see how many likes a post has' do
      @posts.each do |post|
        expect(page).to have_content(post.likes_counter.to_s)
      end
    end

    it 'can a section of pagination if there are more posts than fit on the view' do
      expect(page).to have_content 'Pagination'
    end
  end

  describe 'GET show/page' do
    it 'redirects me to that post\'s show page when I click on a post.' do
      post = @posts.first
      click_link(post.title)
      expect(page).to have_current_path(user_post_path(post.author, post))
    end
  end
end
