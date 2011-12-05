# -*- encoding : utf-8 -*-
require_relative '../spec_helper_lite'
require_relative '../../app/presenters/picture_post_presenter'

describe PicturePostPresenter do
  before do
    @post = OpenStruct.new(
      title:        "TITLE", 
      body:         "BODY", 
      published_at: "PUBLISHED_AT")
    @template = stub!
    @subject = PicturePostPresenter.new(@post, @template)
  end

  it "delegates method calls to the post" do
    @subject.title.must_equal "TITLE"
    @subject.body.must_equal "BODY"
    @subject.published_at.must_equal "PUBLISHED_AT"
  end

  it "renders itself with the appropriate partial" do
    mock(@template).render(
      partial: "/posts/picture_body", locals: {post: @subject}){
      "THE_HTML"
    }
    @subject.render_body.must_equal "THE_HTML"
  end
end
