defmodule WhyAmIUsingThisTrackerWeb.MoodData do
  use Ecto.Schema
  import Ecto.Changeset

  schema "mood_data" do
    field :mood, :string

    timestamps()
  end

  @doc false
  def changeset(mood_data, attrs) do
    mood_data
    |> cast(attrs, [:mood])
    |> validate_required([:mood])
  end

  def create_mood(attrs \\ %{}) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def list_moods do
    Repo.all(__MODULE__)
  end

  def get_mood!(id) do
    Repo.get!(__MODULE__, id)
  end

  def update_mood(mood_data, attrs) do
    mood_data
    |> changeset(attrs)
    |> Repo.update()
  end

  def delete_mood(mood_data) do
    Repo.delete(mood_data)
  end
end
