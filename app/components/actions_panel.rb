

class ActionsPanel
  include Inesita::Component

  include Actions

  def render
    div(class: "container") {
      #  actions / buttons
      div(class: "s-40")

      div(class: "row") {
        div(class: "col s12") {
          form(action: "#") {
            h5 { text "Load Configs from XML file" }
            text "Select a VESC XML file to load the configs (you need to 'Export XML' on BLDC tool)"
            div(class: "s-20")

            input(type: "file", name: "config", onchange: method(:xml_load) )

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

      # button(class: "waves-effect waves-light btn", onclick: method(:xml_load)) {
      #   text "Load XML"
      # }

      # span(class: "hs-150")

      div(class: "s-40")

      button(class: "waves-effect waves-light btn", onclick: method(:save)) {
        text "Save to browser"
      }

      # span(class: "hs-10")
      div(class: "s-30")

      button(class: "waves-effect waves-light btn", onclick: method(:xml_load_default)) {
        text "Load default configs"
      }

      # button(class: "waves-effect waves-light btn", onclick: method(:xml_load_default)) {
      #   text "Load from URL"
      # }


      div(class: "s-20")


      # button(class: "waves-effect waves-light btn", onclick: method(:xml_export)) {
      #   text "Export XML"
      # }

      div(class: "s-30")
    }

  end

end
