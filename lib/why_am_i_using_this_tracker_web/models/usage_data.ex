defmodule WhyAmIUsingThisTrackerWeb.UsageData do
  use Ecto.Schema
  import Ecto.Changeset

  schema "usage_data" do
    field :app, :string
    field :duration, :integer

    timestamps()
  end

  @doc false
  def changeset(usage_data, attrs) do
    usage_data
    |> cast(attrs, [:app, :duration])
    |> validate_required([:app, :duration])
  end

  def create_usage_data(attrs \\ %{}) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def list_usage_data do
    Repo.all(__MODULE__)
  end

  def get_usage_data!(id) do
    Repo.get!(__MODULE__, id)
  end
end
