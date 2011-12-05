# -*- encoding : utf-8 -*-
require_relative '../spec_helper_lite'

require 'active_model'
require 'date'

require_relative '../../app/models/post'

describe Post do
  before do
    @subject = Post.new(title: 'Valid title')
  end
  
  describe 'for newly created posts' do
    before do
      @subject = Post.new
    end

    it "should start with blank attributes" do
      @subject.title.must_be_nil
      @subject.body.must_be_nil
    end
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
  
  describe 'validations' do
    it 'should not be valid with a blank title' do
      [nil, "", " "].each do |bad_title|
        @subject.title = bad_title
        refute(@subject.valid?)
      end
    end
    it 'should be valid with a non-blank title' do
      @subject.title = 'x'
      assert(@subject.valid?)
    end
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
    
    describe "given an invalid post" do
      before do
        @subject.title = nil
      end

      it "should not add the post to the blog" do
        dont_allow(@blog).add_post
        @subject.publish
      end

      it "should return false" do
        refute(@subject.publish)
      end
    end
  end
  
  it "should support setting attributes in the initializer" do
    subject = Post.new(:title => "mytitle", :body => "mybody")
    subject.title.must_equal "mytitle"
    subject.body.must_equal "mybody"
  end
  
  describe "#published_at" do
    describe 'before publishing' do
      it 'should be blank' do
        @subject.published_at.must_be_nil
      end
    end
    
    describe 'after publishing' do
      before do
        @clock = stub!
        @now = DateTime.parse("2011-09-11T02:56")
        stub(@clock).now(){@now}

        @subject.blog = stub!
        @subject.publish(@clock)
      end

      it 'should be a datetime' do
        @subject.published_at.must_equal(@now)
      end
    end
  end
end
