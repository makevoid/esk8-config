require 'configurator'

class ConfigGroup
  include Inesita::Component

  attr_reader :key

  def initialize(key:)
    @key = key
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

  def xml_load(e)

  end

  def save(e)
    @store.save!
  end

  def xml_export(e)

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
            div(class: "col s6") {
              # Configurator.core_configs_plain.each do |key|

              h5 { text "Current Limits - Motor" }
              Configurator.core_configs[:current_motor].each { |key|
                component ConfigGroup.new key: key
              }
              div(class: "s-80")

              h5 { text "RPM Limiting" }
              Configurator.core_configs[:rpm_limiting].each { |key|
                component ConfigGroup.new key: key
              }
              div(class: "s-80")

              h5 { text "BLDC" }
              Configurator.core_configs[:bldc].each { |key|
                component ConfigGroup.new key: key
              }
            }

            div(class: "col s6") {

              h5 { text "Current Limits - Battery" }
              Configurator.core_configs[:current_battery].each { |key|
                component ConfigGroup.new key: key
              }

              h5 { text "Battery" }
              Configurator.core_configs[:battery].each { |key|
                component ConfigGroup.new key: key
              }

            }
          }
        }
      }
      div(class: "s-20")

      #  actions / buttons
      div(class: "s-30")

      div(class: "row") {
        div(class: "col s6") {
          form(action: "#") {
            input(type: "file", name: "config")

          #   div(class: "file-field input-field") {
          #     div(class: "btn") {
          #       span { text "XML config file" }
          #       input(type: "file", name: "config")
          #     }
          #   }
          #   div(class: "file-path-wrapper") {
          #     input(class: "file-path validate", type: "text")
          #   }
          }
        }
      }

      button(class: "waves-effect waves-light btn", onclick: method(:xml_load)) {
        text "Load XML"
      }

      span(class: "hs-150")

      button(class: "waves-effect waves-light btn", onclick: method(:xml_load)) {
        text "Load default configs"
      }


      div(class: "s-60")

      button(class: "waves-effect waves-light btn", onclick: method(:save)) {
        text "Save"
      }
      span(class: "hs-10")

      button(class: "waves-effect waves-light btn", onclick: method(:xml_export)) {
        text "Export XML"
      }

      div(class: "s-30")
    end

  end
end
