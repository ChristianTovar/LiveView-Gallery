defmodule GalleryWeb.GalleryLive do
  use Phoenix.LiveView

  @cards_list [
    "https://images.unsplash.com/photo-1562971179-4ad6903a7ed6?h=500&fit=crop",
    "https://images.unsplash.com/photo-1552673597-e3cd6747a996?h=500&fit=crop",
    "https://images.unsplash.com/photo-1561133036-61a7ed56b424?h=500&fit=crop",
    "https://images.unsplash.com/photo-1530717449302-271006cdc1bf?h=500&fit=crop"
  ]

  @list_size length(@cards_list)

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :index, 0)}
  end

  def render(assigns) do
    ~L"""
    <label>Index: <%= @index %></label>
    <button phx-click="previous">Previous</button>
    <button phx-click="next">Next</button>

    <img src="<%= get_image(@index) %>">
    """
  end

  def handle_event("previous", _, socket) do
    {:noreply, update(socket, :index, &(&1 - 1))}
  end

  def handle_event("next", _, socket) do
    {:noreply, update(socket, :index, &(&1 + 1))}
  end

  defp get_image(index) do
    Enum.at(@cards_list, rem(index, @list_size))
  end
end
