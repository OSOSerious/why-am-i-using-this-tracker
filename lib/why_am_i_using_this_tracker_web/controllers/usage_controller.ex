defmodule WhyAmIUsingThisTrackerWeb.UsageController do
  use WhyAmIUsingThisTrackerWeb, :controller

  alias WhyAmIUsingThisTracker.UsageData

  def index(conn, _params) do
    usage_data = UsageData.list_usage_data()
    render(conn, "index.json", usage_data: usage_data)
  end

  def create(conn, %{"usage_data" => usage_data_params}) do
    with {:ok, %UsageData{} = usage_data} <- UsageData.create_usage_data(usage_data_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.usage_path(conn, :show, usage_data))
      |> render("show.json", usage_data: usage_data)
    else
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset})
    end
  end

  def show(conn, %{"id" => id}) do
    usage_data = UsageData.get_usage_data!(id)
    render(conn, "show.json", usage_data: usage_data)
  end

  def track_app_usage(conn, %{"app" => app, "duration" => duration}) do
    case UsageData.create_usage_data(%{app: app, duration: duration}) do
      {:ok, usage_data} ->
        conn
        |> put_status(:created)
        |> render("show.json", usage_data: usage_data)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset})
    end
  end

  def track_user_feedback(conn, %{"question" => question, "response" => response}) do
    case UserResponses.create_response(%{question: question, response: response}) do
      {:ok, _user_response} ->
        send_resp(conn, :created, "User feedback tracked successfully")
      {:error, _changeset} ->
        send_resp(conn, :unprocessable_entity, "Failed to track user feedback")
    end
  end
end
