require 'configurator'
# require 'config_group'

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

  def confs(section)
    Configurator.core_configs[section] || {}
  end

  def render
    div class: 'container' do

      section(class: "calc-form") {
        form {
          div(class: "row") {
            div(class: "col s6") {
              # confs_plain.each do |key|

              h5 { text "Current Limits - Motor" }
              confs(:current_motor).each { |key|
                component ConfigGroup.new key: key
              }
              div(class: "s-80")

              h5 { text "RPM Limiting" }
              confs(:rpm_limiting).each { |key|
                component ConfigGroup.new key: key
              }
              div(class: "s-80")

              h5 { text "BLDC" }
              confs(:bldc).each { |key|
                component ConfigGroup.new key: key
              }
            }

            div(class: "col s6") {

              h5 { text "Current Limits - Battery" }
              confs(:current_battery).each { |key|
                component ConfigGroup.new key: key
              }

              h5 { text "Battery" }
              confs(:battery).each { |key|
                component ConfigGroup.new key: key
              }

            }
          }
        }
      }
      div(class: "s-20")
    end

  end
end
