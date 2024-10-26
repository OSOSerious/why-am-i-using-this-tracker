defmodule WhyAmIUsingThisTrackerWeb.UsageView do
  use WhyAmIUsingThisTrackerWeb, :view

  def render("index.json", %{usage_data: usage_data}) do
    %{data: render_many(usage_data, __MODULE__, "usage.json")}
  end

  def render("show.json", %{usage_data: usage_data}) do
    %{data: render_one(usage_data, __MODULE__, "usage.json")}
  end

  def render("usage.json", %{usage_data: usage_data}) do
    %{
      id: usage_data.id,
      app: usage_data.app,
      duration: usage_data.duration,
      inserted_at: usage_data.inserted_at,
      updated_at: usage_data.updated_at
    }
  end
end
