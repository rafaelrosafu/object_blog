# -*- encoding : utf-8 -*-
class Post
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :blog, :title, :body
  
  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value)
    end 
  end

  def publish
    blog.add_post self
  end
  
  def persisted?
    false
  end
end
