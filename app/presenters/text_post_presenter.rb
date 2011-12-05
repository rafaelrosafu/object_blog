# -*- encoding : utf-8 -*-
require_relative 'presenter'

class TextPostPresenter < Presenter
  def render_body
    @template.render(partial: "/posts/text_body", locals: {post: self})
  end
end
