class Layout
  include Inesita::Layout
  include URLUpdater

  def initialize
    block = lambda do
      url_load_values!
      render!
    end

    `window.setTimeout(#{block.to_n}, 300)`
    `window.setTimeout(#{block.to_n}, 1000)`

    `on_hash_change = #{on_hash_change.to_n}`
    $$.window.addEventListener "hashchange", `on_hash_change`

    # $document.ready do
    #   # %x{
    #   #   var $ = window.jQuery
    #   #   $('ul.tabs').tabs()
    #   # }
    # end
  end


  def on_hash_change
    -> (e) {
      url_load_values!
    }
  end

  def render
    div class: 'outer-container' do
      component NavBar
      component router
      component ActionsPanel
      component Status
    end

    url_update!

    # TODO: fix bug with materialize tabs (href w hash?)
    # script(src: "/static/js/vendor/jquery.js", type: "text/javascript")
    # script(src: "/static/js/vendor/materialize.js", type: "text/javascript")
    script(src: "/static/js/vendor/x2js.js", type: "text/javascript")
    script(src: "/static/js/vendor/underscore.js", type: "text/javascript")
  end
end
