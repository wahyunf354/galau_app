defmodule GalauApp.Accounts do
  alias GalauApp.Accounts.User

  def list_users do
    [
      %User{id: 1, email: "wahyu@mail.com"},
      %User{id: 2, email: "fadil@mail.com"},
      %User{id: 3, email: "lain@mail.com"}
    ]
  end

  def get_user(id) do
    Enum.find(list_users(), fn user -> user.id == id end)
  end

  def get_user_by(params) do
    Enum.find(list_users(), fn user ->
      Enum.all?(params, fn {key, value} -> Map.get(user, key) === value end)
    end)
  end
end
