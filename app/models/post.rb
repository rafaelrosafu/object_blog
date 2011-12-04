# -*- encoding : utf-8 -*-
class Post
  attr_accessor :blog, :title, :body
  
  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value)
    end 
  end

  def publish
    blog.add_post self
  end
end
