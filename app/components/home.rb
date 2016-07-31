require 'configurator'

class Home
  include Inesita::Component

  def initialize
    block = lambda do
      # Calc.calc! @store

      # Configurator.new ...
      render!
    end

    `window.setTimeout(#{block.to_n}, 1000)`
  end

  def change(e)
    key = e.target.name
    val = e.target.value
    `console.log(key, val)`
    @store.set key, val.to_i
    # Calc.calc! @store
    # Configurator.new ...
    render!
  end

  def save(e)
    @store.save!
  end

  def render
    div class: 'container' do

      p(class: "tagline") do
        text "Electric Skateboard VESC ESC Configuration Tool"
      end
      div(class: "s-20")

      section(class: "calc-form") {
        form {
          div(class: "row") {
            div(class: "col s12") {
              h1 { text "SOON!" }
              h6 { text "Current Limits" }
              div(class: "s-10")
            }
          }

          div(class: "row") {
            div(class: "col s12") {

              div(class: "form-group") {
                label(for: "l_current_max") {
                  text "Motor Max"
                }
                input(name: 'l_current_max', value: @store.get("l_current_max"), onkeyup: method(:change), type: "text", id: "l_current_max", class: "form-control")
              }

            }
          }
        }
      }
      div(class: "s-20")

      button(class: "waves-effect waves-light btn", onclick: method(:save)) {
        text "Load XML"
      }
      span(class: "hs-10")

      button(class: "waves-effect waves-light btn", onclick: method(:save)) {
        text "Save"
      }
      span(class: "hs-10")

      button(class: "waves-effect waves-light btn", onclick: method(:save)) {
        text "Export XML"
      }

      div(class: "s-30")
    end

  end
end
