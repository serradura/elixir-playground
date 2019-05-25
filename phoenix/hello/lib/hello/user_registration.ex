defmodule Hello.UserRegistration do
  alias Ecto.Multi
  alias Hello.{Accounts, CMS, Repo}

  def register_user(params) do
    Multi.new()
    |> Multi.run(:user, fn _, _ -> Accounts.create_user(params) end)
    |> Multi.run(:author, fn _, %{user: user} ->
      {:ok, CMS.ensure_author_exists(user)}
    end)
    |> Repo.transaction()
  end
end
