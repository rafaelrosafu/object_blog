require_relative '../spec_helper_lite'
require_relative '../../app/helpers/presenters_helper'

stub_class 'PicturePostPresenter'
stub_class 'TextPostPresenter'
stub_class 'Post'

describe PresentersHelper do
  before do
    @subject = Object.new
    @subject.extend PresentersHelper
    @template = stub!
  end

  it "should decorate picture posts with a PicturePostPresenter" do
    post = Post.new
    stub(post).picture?{true}
    @subject.present(post, @template).must_be_kind_of(PicturePostPresenter)
  end

  it "should decorate text posts with a TextPostPresenter" do
    post = Post.new
    stub(post).picture?{false}
    @subject.present(post, @template).must_be_kind_of(TextPostPresenter)
  end

  it "should leave objects it doesn't know about alone" do
    model = Object.new
    @subject.present(model, @template).must_be_same_as(model)
  end
end
