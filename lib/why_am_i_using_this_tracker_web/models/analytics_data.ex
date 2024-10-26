defmodule WhyAmIUsingThisTrackerWeb.AnalyticsData do
  use Ecto.Schema
  import Ecto.Changeset

  schema "analytics_data" do
    field :user_id, :integer
    field :engagement, :integer
    field :session_duration, :integer
    field :app_usage_pattern, :map

    timestamps()
  end

  @doc false
  def changeset(analytics_data, attrs) do
    analytics_data
    |> cast(attrs, [:user_id, :engagement, :session_duration, :app_usage_pattern])
    |> validate_required([:user_id, :engagement, :session_duration, :app_usage_pattern])
  end

  def create_engagement(attrs \\ %{}) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def create_session_duration(attrs \\ %{}) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def create_app_usage_pattern(attrs \\ %{}) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def list_analytics_data do
    Repo.all(__MODULE__)
  end

  def get_analytics_data!(id) do
    Repo.get!(__MODULE__, id)
  end

  def update_analytics_data(analytics_data, attrs) do
    analytics_data
    |> changeset(attrs)
    |> Repo.update()
  end

  def delete_analytics_data(analytics_data) do
    Repo.delete(analytics_data)
  end
end
