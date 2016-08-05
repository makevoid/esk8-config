# require Inesita
require 'inesita'
# require 'xml-motor'

require 'json'

# require main parts of application
require 'router'
require 'store'
require 'lib/actions'
require 'components/actions_panel'
require 'layout'
require 'seeds'
require 'lib/timeout'
require 'lib/text_helpers'

require 'native'
require 'browser'

# require all components
require_tree './components'


# when document is ready render application to <body>
Inesita::Browser.ready? do
  # setup Inesita application
  Inesita::Application.new(
    router: Router,
    store:  Store,
    layout: Layout
  ).mount_to(Inesita::Browser.body)
end
