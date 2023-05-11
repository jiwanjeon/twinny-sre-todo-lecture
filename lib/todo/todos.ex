defmodule Todo.Todos do
  @moduledoc """
  The Todos context.
  """

  import Ecto.Query, warn: false
  alias Todo.Repo

  alias Todo.Todos.User
  alias Todo.Todos.Todo

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  def list_todos do
    Repo.all(Todo)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  def get_todo!(id), do: Repo.get!(Todo, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  # Todo.Todos.create_user(%{age: "30", email: "test@example.com", name: "jiwanjeon"})
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  # Todo.Todos.create_todo(%{user_id: 1, title: "title", priority: "HIGH", description: "desc", complete: false, notes: "테스트"})
  def create_todo(attrs \\ %{}) do
    %Todo{}
    |> Todo.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, %Todo{} = todo} ->
        {:ok, get_user_by_id(todo.user_id)}
    end
  end

  # Todo.Todos.get_user_by_id(1)
  def get_user_by_id(user_id) do
    from(au in associate_related_user(), where: au.id == ^user_id)
    |> Repo.get(user_id)
  end

  def associate_related_user() do
    from(u in User,
      preload: [todos: ^from(t in Todo)]
    )
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def delete_todo_by_id(todo_id) do
    from(t in Todo, where: t.id == ^todo_id)
    |> Repo.delete_all()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
