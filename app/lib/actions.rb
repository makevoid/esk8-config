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
      `console.log("xml loaded!")`
      # @store.load_json! `contents`
      render!
    `}`
    `reader.addEventListener("loadend", doneLoading)`

    `reader.readAsText(file)`

    # %x{
    #   var contents
    #   var elem = document.querySelector('input[name="config"]')
    #   var file = elem.files[0]
    #   var reader = new FileReader()
    # }
    #
    # `var doneLoading = function(e) {`
    #   `contents = e.target.result`
    #   # `console.log(contents)`
    #   @store.load_xml! `contents`
    #   # @store.load_json! `contents`
    #   render!
    # `}`
    #
    # %x{
    #   reader.addEventListener("loadend", doneLoading)
    #
    #   reader.readAsText(file)
    # }

    # TODO: switch to the new - opal-native code:
    #
    # # debug needed
    #
    # # document = Native `document`
    # elem   = $document.querySelector "input[name=\"config\"]"
    # file   = elem[:files].first
    # reader = Native `new FileReader()`
    # doneLoading = (e) -> {
    #   contents = e.target.result
    #   load_file() #
    #   # load_from_github() TODO
    #   render! # this could be implicit
    # }
    # # doneLoading = renderize doneLoading
    # reader.addEventListener "loadend", doneLoading
    # reader.readAsText file

  end

  def xml_load_default(e)
    json = Configurator::DEFAULT_CONFIG_JSON
    @store.load_json! json
    render!
  end

  def save(e)
    @store.save!
  end

end
