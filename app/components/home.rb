require 'configurator'

class ConfigGroup
  def render
    div(class: "config-group") {
      label(for: key) {
        text Configurator::LABELS.fetch(key)
      }
      
      input(name: key, value: @store.get(key), onkeyup: method(:change), type: "text", id: key, class: key)
    }
  end
end


class Home
  include Inesita::Component

  def initialize
    block = lambda {
      # Calc.calc! @store

      # Configurator.new ...
      render!
    }

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

              h3 { text "Motor Config" }

              # Configurator.core_configs_plain.each do |key|

              Configurator.core_configs[:motor].each do |key|
                component ConfigGroup
              end

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
