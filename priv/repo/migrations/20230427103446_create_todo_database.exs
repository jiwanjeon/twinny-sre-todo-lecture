defmodule Todo.Repo.Migrations.CreateTodoDatabase do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :title, :string
      add :priority, :string
      add :description, :string
      add :complete, :boolean
      add :notes, :string

      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
  end
end
