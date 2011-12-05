# -*- encoding : utf-8 -*-
require_relative '../spec_helper_lite'
require_relative '../../app/models/blog'

require 'date'

describe Blog do
  before do
    @subject = Blog.new
  end

  describe '#entries' do  
    it 'should have no entries' do
      @subject.posts.must_be_empty
    end
    
    def stub_post_with_date(date)
      OpenStruct.new(:published_at => DateTime.parse(date))
    end

    it 'should be sorted in reverse chronological order' do
      oldest = stub_post_with_date("2011-09-09")
      newest = stub_post_with_date("2011-09-11")
      middle = stub_post_with_date("2011-09-10")

      @subject.add_post(oldest)
      @subject.add_post(newest)
      @subject.add_post(middle)
      @subject.posts.must_equal([newest, middle, oldest])
    end

    it "should be limited to 10 items" do
      10.times do |i|
        @subject.add_post(stub_post_with_date("2011-09-#{i+1}"))
      end
      oldest = stub_post_with_date("2011-08-30")
      @subject.add_post(oldest)
      @subject.posts.size.must_equal(10)
      @subject.posts.wont_include(oldest)
    end
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
