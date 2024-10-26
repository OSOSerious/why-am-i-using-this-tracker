defmodule WhyAmIUsingThisTrackerWeb.UserResponses do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_responses" do
    field :question, :string
    field :response, :string

    timestamps()
  end

  @doc false
  def changeset(user_response, attrs) do
    user_response
    |> cast(attrs, [:question, :response])
    |> validate_required([:question, :response])
  end

  def create_response(attrs \\ %{}) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def list_responses do
    Repo.all(__MODULE__)
  end

  def get_response!(id) do
    Repo.get!(__MODULE__, id)
  end
end
