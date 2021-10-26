defmodule TimeManagerWeb.UsersController do
  use TimeManagerWeb, :controller

  alias TimeManager.Posts
  alias TimeManager.Posts.Users

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Posts.change_users(%Users{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"users" => users_params}) do
    case Posts.create_users(users_params) do
      {:ok, users} ->
        conn
        |> put_flash(:info, "Users created successfully.")
        |> redirect(to: Routes.users_path(conn, :show, users))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    users = Posts.get_users!(id)
    render(conn, "show.html", users: users)
  end

  def edit(conn, %{"id" => id}) do
    users = Posts.get_users!(id)
    changeset = Posts.change_users(users)
    render(conn, "edit.html", users: users, changeset: changeset)
  end

  def update(conn, %{"id" => id, "users" => users_params}) do
    users = Posts.get_users!(id)

    case Posts.update_users(users, users_params) do
      {:ok, users} ->
        conn
        |> put_flash(:info, "Users updated successfully.")
        |> redirect(to: Routes.users_path(conn, :show, users))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", users: users, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    users = Posts.get_users!(id)
    {:ok, _users} = Posts.delete_users(users)

    conn
    |> put_flash(:info, "Users deleted successfully.")
    |> redirect(to: Routes.users_path(conn, :index))
  end
end
