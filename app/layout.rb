class Layout
  include Inesita::Layout

  def initialize
    $document.ready do
      # %x{
      #   var $ = window.jQuery
      #   $('ul.tabs').tabs()
      # }
    end
  end

  def render
    div class: 'outer-container' do
      component NavBar
      component router
      component ActionsPanel
    end

    script(src: "/static/js/vendor/jquery.js", type: "text/javascript")
    script(src: "/static/js/vendor/materialize.js", type: "text/javascript")
    script(src: "/static/js/vendor/x2js.js", type: "text/javascript")
  end
end
