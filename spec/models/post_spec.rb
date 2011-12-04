# -*- encoding : utf-8 -*-
require 'minitest/autorun'
require_relative '../../app/models/post'

describe Post do
  before do
    @subject = Post.new
  end

  it "should start with blank attributes" do
    @subject.title.must_be_nil
    @subject.body.must_be_nil
  end

  it "should support reading and writing a title" do
    @subject.title = "foo"
    @subject.title.must_equal "foo"
  end

  it "should support reading and writing a post body" do
    @subject.body = "foo"
    @subject.body.must_equal "foo"
  end

  it "should support reading and writing a blog reference" do
    blog = Object.new
    @subject.blog = blog
    @subject.blog.must_equal blog
  end

  describe "#publish" do
    before do
      @blog = MiniTest::Mock.new
      @subject.blog = @blog
    end

    after do
      @blog.verify
    end

    it "should add the post to the blog" do
      @blog.expect :add_post, nil, [@subject]
      @subject.publish
    end
  end
  
  it "should support setting attributes in the initializer" do
    subject = Post.new(:title => "mytitle", :body => "mybody")
    subject.title.must_equal "mytitle"
    subject.body.must_equal "mybody"
  end
end
