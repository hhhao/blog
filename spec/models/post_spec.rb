require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it 'requires a title' do
      p = Post.new
      p.valid?
      expect(p.errors).to have_key(:title)
    end

    it 'requires min title length' do
      p = Post.new(title: '123456')
      p.valid?
      expect(p.errors).to have_key(:title)
    end

    it 'requires a body' do
      p = Post.new
      p.valid?
      expect(p.errors).to have_key(:body)
    end

    it 'body_snippet method works' do
      body = ''
      150.times do
        body += 'a'
      end
      snip = '...'
      100.times do
        snip = 'a' + snip
      end
      p = Post.new(body: body)
      expect(p.body_snippet).to eq snip
    end
  end
end
