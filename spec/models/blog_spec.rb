# -*- encoding : utf-8 -*-
require_relative '../spec_helper_lite'
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

    it "should accept an attribute hash on behalf of the post maker" do
      post_maker = MiniTest::Mock.new
      post_maker.expect(:call, @new_post, [{:x => 42, :y => 'z'}])
      @subject.post_maker = post_maker
      @subject.new_post(:x => 42, :y => 'z')
      post_maker.verify
    end  
  end
  
  describe '#add_post' do
    it 'should add a new post to the blog' do
      post = Object.new
      @subject.add_post post
      @subject.posts.must_include post
    end
  end
end
