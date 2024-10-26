defmodule WhyAmIUsingThisTrackerWeb.PromptController do
  use WhyAmIUsingThisTrackerWeb, :controller

  alias WhyAmIUsingThisTracker.UserResponses

  def index(conn, _params) do
    user_responses = UserResponses.list_responses()
    render(conn, "index.json", user_responses: user_responses)
  end

  def create(conn, %{"user_response" => user_response_params}) do
    case UserResponses.create_response(user_response_params) do
      {:ok, %UserResponses{} = user_response} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.prompt_path(conn, :show, user_response))
        |> render("show.json", user_response: user_response)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset})
    end
  end

  def show(conn, %{"id" => id}) do
    user_response = UserResponses.get_response!(id)
    render(conn, "show.json", user_response: user_response)
  end
end
