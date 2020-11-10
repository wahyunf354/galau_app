defmodule GalauAppWeb.UsersController do
  use GalauAppWeb, :controller
  alias GalauApp.Accounts
  alias GalauApp.Accounts.User

  def index(conn, _params) do
    users = Accounts.list_users()

    conn
    |> render("index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user(String.to_integer(id))
    render(conn, "show.html", user: user)
  end

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "#{user.name} creted")
        |> redirect(to: Routes.users_path(conn, :index))

      # FIXME: tidak ada validasi jika register tidak sesuai
      {:error, %Ecto.Changeset{} = changset} ->
        render(conn, "new.html", changset: changset)
    end
  end
end
