class XMLParser
  def initialize(xml_string)
    @parser = Native `new DOMParser()`
    @doc = @parser.parseFromString xml_string, "application/xml"
  end

  def get(key)
    result = @doc.evaluate key, @doc, nil, `XPathResult.STRING_TYPE`, nil
    result[:stringValue]
  end
end
