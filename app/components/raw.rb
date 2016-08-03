class Raw
  include Inesita::Component

  def initialize
    Timeout.new do
      @conf = @store.configurator if @store
      render!
    end

    # :text, :xml, :json
    @panel = :text
  end

  # action(s)

  def switch_panel(value)
    @panel = value
    render!
  end

  # ---

  def js_void
    "javascript:void(0)"
  end

  def render

    div(class: "container") {
      div {
        div(class: "col s12") {
          ul(class: "tabs") {
            li(class: "tab col s6") {
              a(href: js_void, class: "red-text #{"active" if @panel == :text}", onclick: -> { switch_panel(:text) }) { text "Text" }
            }
            li(class: "tab col s6") {
              a(href: js_void, class: "red-text #{"active" if @panel == :xml}", onclick: -> { switch_panel(:xml) }) { text "XML" }
            }
            li(class: "tab col s6") {
              a(href: js_void, class: "red-text #{"active" if @panel == :json}", onclick: -> { switch_panel(:json) }) { text "JSON" }
            }
          }
        }

        pre {
          if @conf
            case @panel
            when :text
              text @conf.to_hrfl
            when :xml
              text @conf.to_xml
            when :json
              txt = @conf.to_json_fmt
              # txt = `JSON.stringify(txt, null, 2)`
              # textarea(disabled: true) {
              txt = @conf.config.to_n
              txt = `JSON.stringify(txt, null, 2)`

              text txt
              # }
            end
          end
        }
      }
    }
  end
end
