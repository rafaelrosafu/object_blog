# -*- encoding : utf-8 -*-
class Post
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :blog, :title, :body, :published_at
  
  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value)
    end 
  end

  def publish(clock = DateTime)
    self.published_at = clock.now
    blog.add_post self
  end
  
  def persisted?
    false
  end
end
