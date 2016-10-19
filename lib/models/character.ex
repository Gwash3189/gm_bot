defmodule GmBot.Models.Character do
  use Ecto.Schema


  @unique_name_error "A character by that name already exists"

  schema "characters" do
    field :name, :string
    field :owner, :string
    field :current_hp , :integer
    field :max_hp , :integer

    timestamps
  end

  def changeset(character, params \\ %{}) do
    character
      |> Ecto.Changeset.cast(params, [:name])
      |> Ecto.Changeset.validate_required([:name, :owner])
      |> Ecto.Changeset.unique_constraint(:name, message: @unique_name_error)
  end
end
