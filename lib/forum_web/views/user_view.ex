defmodule ForumWeb.UserView do
  use ForumWeb, :view
  alias ForumWeb.UserView
  alias Forum.Posts.Post

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      posts: for(post <- user.posts, do: post_data(post))
    }
  end

  def post_data(%Post{} = post) do
    %{id: post.id, title: post.title, body: post.body}
  end
end
