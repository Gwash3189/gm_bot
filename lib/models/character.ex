defmodule GmBot.Models.Character do
  use Ecto.Schema
  import Ecto.Query
  alias GmBot.Models.Character


  @unique_name_error "A character by that name already exists"

  schema "characters" do
    field :name, :string
    field :owner, :string
    field :current_hp, :integer
    field :max_hp, :integer
    field :strength, :integer
    field :strength_modifier, :integer
    field :dexterity, :integer
    field :dexterity_modifier, :integer
    field :constitution, :integer
    field :constitution_modifier, :integer
    field :intelligence, :integer
    field :intelligence_modifier, :integer
    field :wisdom, :integer
    field :wisdom_modifier, :integer
    field :charisma, :integer
    field :charisma_modifier, :integer

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

  def update(owner, name, params \\ %{}) do
    character = query(owner, name)
    queried_character = GmBot.Repo.one(character)
    changeset_result = changeset(queried_character, params)

    GmBot.Repo.update(changeset_result)
  end

  def changeset(character, params \\ %{}) do
    character
      |> Ecto.Changeset.cast(params, [
        :name,
        :owner,
        :current_hp,
        :max_hp,
        :strength,
        :strength_modifier,
        :dexterity,
        :dexterity_modifier,
        :constitution,
        :constitution_modifier,
        :intelligence,
        :intelligence_modifier,
        :wisdom,
        :wisdom_modifier,
        :charisma,
        :charisma_modifier
      ])
      |> Ecto.Changeset.validate_required([:name, :owner])
      |> Ecto.Changeset.unique_constraint(:name, message: @unique_name_error)
  end
end
