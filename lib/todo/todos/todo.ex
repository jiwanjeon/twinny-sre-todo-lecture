defmodule Todo.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field(:title, :string)
    field(:priority, :string)
    field(:description, :string)
    field(:complete, :boolean)
    field(:notes, :string)

    belongs_to(:user, Todo.Todos.User)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:title, :priority, :description, :complete, :notes, :user_id])
    |> validate_required([:title, :priority, :description, :complete, :notes, :user_id])
  end
end
