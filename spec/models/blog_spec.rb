# -*- encoding : utf-8 -*-
require 'minitest/autorun'
require_relative '../../app/models/blog'

describe Blog do
  before do
    @subject = Blog.new
  end
  
  it 'should have no entries' do
    @subject.entries.must_be_empty
  end
end
