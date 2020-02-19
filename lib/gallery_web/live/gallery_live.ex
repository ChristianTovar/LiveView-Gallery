defmodule GalleryWeb.GalleryLive do
  use Phoenix.LiveView
  alias Gallery

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :index, 0)}
  end

  def render(assigns) do
    ~L"""
    <div>
      <center>
        <button phx-click="previous">Previous</button>
        <button phx-click="next">Next</button>
      </center>
    </div>
    <div>
      <center>
        <%= for id <- Gallery.image_ids() do %>
          <img src="<%= Gallery.thumb_url(id) %>"
          class="<%= thumb_css_class(id, @index) %>">
        <% end %>
      </center>
    </div>
    <img src="<%= Gallery.get_image(@index, :large) %>">
    """
  end

  def handle_event("previous", _, socket) do
    {:noreply, update(socket, :index, &(&1 - 1))}
  end

  def handle_event("next", _, socket) do
    {:noreply, update(socket, :index, &(&1 + 1))}
  end

  def thumb_css_class(thumb_id, current_id) do
    id = Enum.at(Gallery.image_ids(), rem(current_id, Gallery.size()))

    cond do
      thumb_id == id -> "thumb-selected"
      thumb_id != id -> "thumb-unselected"
    end
  end
end
