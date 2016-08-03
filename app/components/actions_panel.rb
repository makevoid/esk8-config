# actions methods

module Actions

  def xml_load(e)
    # FileReader.new # TODO
    `var contents`
    `var elem = document.querySelector('input[name="config"]')`
    `var file = elem.files[0]`
    `var reader = new FileReader()`
    `var doneLoading = function(e) {`
      `contents = e.target.result`
      # `console.log(contents)`
      @store.load_xml! `contents`
      # @store.load_json! `contents`
      render!
    `}`
    `reader.addEventListener("loadend", doneLoading)`

    `reader.readAsText(file)`

  end

  def xml_load_default(e)

  end

  def save(e)
    @store.save!
  end

  def xml_export(e)

  end

end


# ---

class ActionsPanel
  include Inesita::Component

  include Actions

  def render
    div(class: "container") {
      #  actions / buttons
      div(class: "s-30")

      div(class: "row") {
        div(class: "col s6") {
          form(action: "#") {
            text "Select a VESC XML file to load the configs"
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

      span(class: "hs-150")

      button(class: "waves-effect waves-light btn", onclick: method(:xml_load_default)) {
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
    }

  end

end
