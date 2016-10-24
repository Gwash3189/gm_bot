defmodule GmBot.Models.Character do
  use Ecto.Schema
  import Ecto.Query
  alias GmBot.Models.Character


  @unique_name_error "A character by that name already exists"

  schema "characters" do
    field :name, :string
    field :owner, :string
    field :current_hp , :integer
    field :max_hp , :integer

    timestamps
  end

  def query(owner, name) do
    from c in Character,
      where: c.owner == ^owner and c.name == ^name,
      select: c
  end

  def get(%{user: owner, name: name}) do
    character = query(owner, name)
      |> GmBot.Repo.one

    case character do
      nil -> :no_character_found
      character -> character
    end
  end

  def update(owner, name, params) do
    character = query(owner, name)

    changeset = GmBot.Repo.one(character)
      |> changeset(params)

    GmBot.Repo.update(changeset)
  end

  def changeset(character, params \\ %{}) do
    character
      |> Ecto.Changeset.cast(params, [:name, :owner, :max_hp, :current_hp])
      |> Ecto.Changeset.validate_required([:name, :owner])
      |> Ecto.Changeset.unique_constraint(:name, message: @unique_name_error)
  end
end
