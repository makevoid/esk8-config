require 'calc'

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
    div class: 'jumbotron text-center' do
      h1 do
        text "VESC Config Tool"
      end
      p(class: "tagline") do
        text "Electric Skateboard VESC ESC Configuration Tool"
      end
      div(class: "s20")

      section(class: "calc-form") {
        form {
          div(class: "row") {
            div(class: "col-xs-12") {
              h1 { text "Current Limits" }
              div(class: "s10")
            }
          }

          div(class: "row") {
            div(class: "col-md-4 col-xs-12") {

              div(class: "form-group") {
                label(for: "l_current_max") {
                  text "Number of Cells (6S-12S)"
                }
                input(name: 'l_current_max', value: @store.get("l_current_max"), onkeyup: method(:change), type: "text", id: "l_current_max", class: "form-control")
              }

            }
          }
        }
      }
      div(class: "s20")

      button(onclick: method(:save)) {
        text "Save"
      }

      div(class: "s30")
    end

  end
end
