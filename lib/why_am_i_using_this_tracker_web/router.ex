defmodule WhyAmIUsingThisTrackerWeb.Router do
  use WhyAmIUsingThisTrackerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", WhyAmIUsingThisTrackerWeb do
    pipe_through :api

    resources "/usage_data", UsageController, only: [:index, :create, :show]
    resources "/user_responses", PromptController, only: [:index, :create, :show]
    resources "/analytics_data", AnalyticsController, only: [:index, :create, :show]
    resources "/mood_data", MoodController, only: [:index, :create, :show]
    resources "/gamification_data", GamificationController, only: [:index, :create, :show]
    resources "/marketing_data", MarketingController, only: [:index, :create, :show]
  end
end
