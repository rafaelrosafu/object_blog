class Blog
  attr_reader :posts
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
