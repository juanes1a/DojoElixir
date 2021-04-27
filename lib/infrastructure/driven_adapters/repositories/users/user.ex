defmodule DojoElixir.Adapters.Repositories.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :integer, []}
  @derive {Poison.Encoder, only: [:id, :name, :last_name, :email, :url_image]}
  schema "Users" do
    field(:name, :string)
    field(:last_name, :string)
    field(:email, :string)
    field(:url_image, :string)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :last_name, :email, :url_image])
    |> validate_required([:name, :last_name, :email, :url_image])
  end
end
