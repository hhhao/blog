require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "#new" do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template(:new)
    end
    it 'instantiates a var that is new Post instance' do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "#create" do
    context 'with valid params' do
      def valid_request
        post :create, params: {post: attributes_for(:post)}
      end
      it 'saves record to DB' do
        count_before = Post.count
        valid_request
        count_after = Post.count
        expect(count_after).to eq(count_before + 1)
      end
      it 'redirects to posts_path' do
        valid_request
        expect(response).to redirect_to(posts_path)
      end
    end
    context 'with invalid params' do
      def invalid_request
        post :create, params: {post: attributes_for(:post, title: nil)}
      end
      it 'does not save record to DB' do
        count_before = Post.count
        invalid_request
        count_after = Post.count
        expect(count_after).to eq(count_before)
      end
      it 'renders :new' do
        invalid_request
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#show" do
    it 'renders show template' do
      p = create(:post)
      get :show, id: p.id
      expect(response).to render_template(:show)
    end
    it 'instantiates post var with same id as passed' do
      p = create(:post)
      get :show, id: p.id
      expect(assigns(:post)).to eq(Post.find p.id)
    end
  end

  describe "#index" do
    it 'render index template' do
      get :index
      expect(response).to render_template(:index)
    end
    it 'instantiates posts var containing all posts ordered limit' do
      10.times{create(:post)}
      get :index
      expect(assigns(:posts)).to eq(Post.order(created_at: :desc).limit(10))
    end
  end

  describe "#edit" do
    it 'renders edit template' do
      p = create(:post)
      get :edit, id: p.id
      expect(response).to render_template(:edit)
    end
    it 'instantiates post var with post that is same id as passed' do
      p = create(:post)
      get :edit, id: p.id
      expect(assigns(:post)).to eq(p)
    end
  end

  describe "#update" do
    context 'valid params' do
      def valid_request(p)
        patch :update, params: {id: p.id, post: attributes_for(:post)}
      end
      it 'redirects to posts_path' do
        p = create(:post)
        valid_request(p)
        expect(response).to redirect_to(posts_path)
      end
      it 'updates post that is same id as passed' do
        p = create(:post)
        valid_request(p)
        expect(p.title).not_to eq(Post.last.title)
      end
    end
    context 'invalid params' do
      def invalid_request(p)
        patch :update, params: {id: p.id, post: attributes_for(:post, title: nil)}
      end
      it 'renders edit template' do
        p = create(:post)
        invalid_request(p)
        expect(response).to render_template(:edit)
      end
      it 'does not update the post that is same id as passed' do
        p = create(:post)
        original_title = p.title
        invalid_request(p)
        expect(Post.last.title).to eq(original_title)
      end
    end
  end

  describe "#destroy" do
    it 'redirects to posts_path' do
      p = create(:post)
      delete :destroy, id: p.id
      expect(response).to redirect_to(posts_path)
    end
    it 'deletes the post with same id as passed' do
      p = create(:post)
      count_before = Post.count
      delete :destroy, id: p.id
      count_after = Post.count
      expect(count_after).to eq(count_before - 1)
    end
  end
end
