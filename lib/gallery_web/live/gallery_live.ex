defmodule GalleryWeb.GalleryLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :counter, 0)}
  end

  def render(assigns) do
    ~L"""
    <label>Counter: <%= @counter %></label>
    <button phx-click="incr">+</button>
    """
  end

  def handle_event("incr", _, socket) do
    {:noreply, update(socket, :counter, &(&1 + 1))}
  end
end
