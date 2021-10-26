defmodule TimeManager.PostsTest do
  use TimeManager.DataCase

  alias TimeManager.Posts

  describe "posts" do
    alias TimeManager.Posts.Users

    import TimeManager.PostsFixtures

    @invalid_attrs %{body: nil, title: nil}

    test "list_posts/0 returns all posts" do
      users = users_fixture()
      assert Posts.list_posts() == [users]
    end

    test "get_users!/1 returns the users with given id" do
      users = users_fixture()
      assert Posts.get_users!(users.id) == users
    end

    test "create_users/1 with valid data creates a users" do
      valid_attrs = %{body: "some body", title: "some title"}

      assert {:ok, %Users{} = users} = Posts.create_users(valid_attrs)
      assert users.body == "some body"
      assert users.title == "some title"
    end

    test "create_users/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_users(@invalid_attrs)
    end

    test "update_users/2 with valid data updates the users" do
      users = users_fixture()
      update_attrs = %{body: "some updated body", title: "some updated title"}

      assert {:ok, %Users{} = users} = Posts.update_users(users, update_attrs)
      assert users.body == "some updated body"
      assert users.title == "some updated title"
    end

    test "update_users/2 with invalid data returns error changeset" do
      users = users_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_users(users, @invalid_attrs)
      assert users == Posts.get_users!(users.id)
    end

    test "delete_users/1 deletes the users" do
      users = users_fixture()
      assert {:ok, %Users{}} = Posts.delete_users(users)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_users!(users.id) end
    end

    test "change_users/1 returns a users changeset" do
      users = users_fixture()
      assert %Ecto.Changeset{} = Posts.change_users(users)
    end
  end
end
