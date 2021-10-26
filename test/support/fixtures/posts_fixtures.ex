defmodule TimeManager.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Posts` context.
  """

  @doc """
  Generate a users.
  """
  def users_fixture(attrs \\ %{}) do
    {:ok, users} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title"
      })
      |> TimeManager.Posts.create_users()

    users
  end
end
