class Full
  include Inesita::Component

  def render
    div(class: "container") {
      div {
        text "full config"
      }
    }
  end
end
