defmodule TimeManager.Posts.Users do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
