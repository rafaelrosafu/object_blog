ObjectBlog::Application.routes.draw do
  root :to => "blog#index"
  resource :posts
end
