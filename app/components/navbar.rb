class NavBar
  include Inesita::Component

  def render
    nav(class: 'materialize-red lighten-2', role: 'navigation') {
      div(class: 'nav-wrapper container') {
        a(class: 'brand-logo') {
          text "VESC Config Tool"
        }
        span(class: "tagline") {
          text "Electric Skateboard VESC ESC Configuration Tool"
        }
      }
    }

    div(class: "row red lighten-5") {
      div(class: "col s12") {
        ul(class: "tabs nav-tabs") {
          li(class: "tab col s6") {
            a(href: "/", class: "red-text #{"active" if router.current_url?(:home)}") { text "Basic" }
          }
          li(class: "tab col s6") {
            a(href: "/full", class: "red-text #{"active" if router.current_url?(:full)}") { text "Full" }
          }
          li(class: "tab col s6") {
            a(href: "/raw", class: "red-text #{"active" if router.current_url?(:raw)}") { text "Raw" }
          }
        }
      }
    }
  end
  
end
