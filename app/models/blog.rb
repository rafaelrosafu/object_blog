class Blog
  attr_writer :post_maker

  def initialize
    @posts = []
  end

  def title
    "Watching Paint Dry"
  end

  def subtitle
    "The trusted source for drying paint news & opinion"
  end
  
  def posts
    @posts.sort {|a, b| b.published_at <=> a.published_at}.take(10)
  end

  def new_post(*args)
    post_maker.call(*args).tap do |p|
      p.blog = self
    end
  end

  def add_post(post)
    @posts << post
  end

private
  def post_maker
    @post_maker ||= Post.public_method(:new)
  end
end
