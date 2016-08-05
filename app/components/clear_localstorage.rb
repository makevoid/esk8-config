class ClearLocalStorage
  include Inesita::Component

  def render
    div { text "everything should be clear now!"}
    `localStorage.clear()`
  end
end
