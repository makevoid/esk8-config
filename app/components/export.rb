class Export
  include Inesita::Component

  include Actions

  def initialize
    Timeout.new do
      @conf = @store.configurator if @store
      render!
    end

    Timeout.new(300)  { render! }
    Timeout.new(1000) { render! }

    # :text, :xml, :json
    @panel = :xml
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

  def render_xml_blob
    conf = @store.configurator.to_xml.to_n
    %x{
      var blob = new Blob( [conf], { type: 'application/json' } )

      window.URL = window.URL || window.webkitURL
    }
    blob_url = `window.URL.createObjectURL(blob)`
    @blob_url = blob_url
  end

  def x2js_loaded
    `typeof(X2JS)`.to_n == "function"
  end

  def render
    render_xml_blob if @panel == :xml && x2js_loaded

    div(class: "container") {

      # h4 { t "Export" }
      h4 { text "Export" }

      div(class: "col s12") {
        ul(class: "tabs") {
          li(class: "tab col s6") {
            a(href: js_void, class: "red-text #{"active" if @panel == :xml}", onclick: -> { switch_panel(:xml) }) { text "XML" }
          }
          li(class: "tab col s6") {
            a(href: js_void, class: "red-text #{"active" if @panel == :text}", onclick: -> { switch_panel(:text) }) { text "Text" }
          }
          li(class: "tab col s6") {
            a(href: js_void, class: "red-text #{"active" if @panel == :json}", onclick: -> { switch_panel(:json) }) { text "JSON" }
          }
        }
      }

      if @conf && @panel == :xml
        div(class: "s-40")
        a(class: "waves-effect waves-light btn", href: @blob_url, download: "VESC_Configuration.xml") {
          text "Export XML"
        }
        div(class: "s-20")
      end

      pre {
        if @conf
          case @panel
          when :text
            text @conf.to_hrfl
          when :xml
            conf_xml
          when :json
            conf_json
          end
        end
      }
    }
  end

  def conf_xml
    if x2js_loaded
      xml = @conf.to_xml
      xml = xml.split("><").join(">\n<")
      xml = xml.split("\n").map do |line|
        if %w(<?xml <MCCo </MCC).include? line[0..4]
          line
        else
          "  #{line}"
        end
      end.join("\n")
      text xml
    end
  end

  def conf_json
    txt = @conf.to_json_fmt
    # txt = `JSON.stringify(txt, null, 2)`
    # textarea(disabled: true) {
    txt = @conf.config.to_n
    txt = `JSON.stringify(txt, null, 2)`

    text txt
    # }
  end

end
