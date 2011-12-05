# -*- encoding : utf-8 -*-
class Post
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :blog, :title, :body, :published_at, :image_url

  validates :title, :presence => true
  
  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value)
    end 
  end

  def publish(clock = DateTime)
    return false unless self.valid?
    self.published_at = clock.now
    blog.add_post self
  end
  
  def persisted?
    false
  end
  
  def picture?
    image_url.present?
  end
end
