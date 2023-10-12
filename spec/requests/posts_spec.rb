require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before do
    @user = User.create(name: 'Sam', photo: 'photo.url', bio: 'Excellent', posts_counter: 0)
    @post = Post.create(author: @user, title: 'Let us go', text: 'This is the text for the post', likes_counter: 0,
                        comments_counter: 0)
  end
  describe 'GET/index' do
    before do
      # get user_posts_path(user_id: 1)
      get "/users/#{@user.id}/posts"
    end

    it 'respond with http success' do
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      expect(response).to render_template('posts/index')
    end

    it 'responds with the correct body' do
      expect(response.body).to include('Number of posts')
    end
  end

  # show action

  describe 'GET/show' do
    before do
      # get user_post_url(user_id: 1, id: 1)
      get "/users/#{@user.id}/posts/#{@post.id}"
    end

    it 'respond with http success' do
      expect(response.status).to eq(200)
    end

    it 'renders the correct template' do
      expect(response).to render_template('posts/show')
    end

    it 'responds with the correct body' do
      expect(response.body).to include('Comments')
    end
  end
end
