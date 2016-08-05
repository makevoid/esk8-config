module URLUpdater
  def url_update!
    store_json = "#{@store.configurator.to_json_fmt}|"
    if @store.previous_hash != "" && @store.previous_hash != store_json
      $$.location.hash   = store_json
    end
    @store.previous_hash = store_json
  end

  def url_load_values!
    hash = $$.location.hash
    return if !hash || hash == "" || hash == "#"
    json_configs  = hash
    json_configs  = json_configs[1..-1]

    # decode the url it it's CGI encoded
    json_configs = $$.decodeURI json_configs if json_configs[0] == "%"

    json_configs = json_configs[0..-2].to_n
    @store.load_json! json_configs
  end
end
