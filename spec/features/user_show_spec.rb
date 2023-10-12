require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  # let(:user) { User.create(name: 'Diana', photo: 'https://example.com/path-to-image.jpg', bio: 'Web Developer', posts_counter: 3) }
  before(:each) do
    @diana = User.create(name: 'Diana', photo: 'https://dianalinktophoto.jpg', bio: 'be the diffrence',
                         posts_counter: 0)
  end

  describe 'user#show' do
    before(:each) do
      @diana = User.create(name: 'Diana', photo: 'https://dianalinktophoto.jpg', bio: 'be the diffrence',
                           posts_counter: 0)
      @posts = [
        Post.create(author: @diana, title: 'User Post 1', text: 'This is User Post 1', comments_counter: 0,
                    likes_counter: 0),
        Post.create(author: @diana, title: 'User Post 2', text: 'This is User Post 2', comments_counter: 0,
                    likes_counter: 0),
        Post.create(author: @diana, title: 'User Post 3', text: 'This is User Post 3', comments_counter: 0,
                    likes_counter: 0)
      ]
      visit user_path(@diana)
    end
    it "can see the user's profile picture" do
      #  expect(page).to have_css("img[src*='#{@diana.photo}']")
      expect(page).to have_xpath("//img[contains(@src,'https://dianalinktophoto.jpg')]")
    end

    it "can see the user's username" do
      expect(page).to have_content(@diana.name)
    end

    it 'can see the number of posts the user has written' do
      expect(page).to have_content("Number of posts: #{@diana.posts_counter}")
    end

    it "can see the user's bio" do
      expect(page).to have_content(@diana.bio)
    end

    it "can see the user's first 3 posts" do
      @diana.posts.limit(3).each do |post|
        expect(page).to have_content(post.text)
      end
    end

    it "can see a button that lets me view all of a user's posts" do
      # expect(page).to have_link('See All Posts', href: user_posts_path(@diana), class: 'btn center-btn')
      expect(page).to have_content 'See all posts'
    end

    it "When I click a user's post, it redirects me to that post's show page" do
      post = @diana.posts.first
      click_link('User Post 1')
      expect(page).to have_current_path(user_post_path(@diana, post))
    end

    it "When I click to see all posts, it redirects me to the user's post's index page" do
      click_link 'See all posts'
      expect(current_path).to eq(user_posts_path(@diana))
    end
  end
end
