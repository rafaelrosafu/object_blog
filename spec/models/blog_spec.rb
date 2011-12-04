# -*- encoding : utf-8 -*-
require 'minitest/autorun'
require_relative '../../app/models/blog'

require 'ostruct'

describe Blog do
  before do
    @subject = Blog.new
  end
  
  it 'should have no entries' do
    @subject.posts.must_be_empty
  end

  describe "#new_post" do
    before do
      @new_post = OpenStruct.new
      @subject.post_maker = ->{ @new_post }
    end

    it "should return a new post" do
      @subject.new_post.must_equal @new_post
    end

    it "should set the post's blog reference to itself" do
      @subject.new_post.blog.must_equal(@subject)
    end
  end
end
