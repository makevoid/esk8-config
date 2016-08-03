module TextHelpers
  def humanize(string)
    string = keys_prefixes_remove string
    string.split(/_| /).map do |w|
      unless w.upcase == w
        w.capitalize
      else
        w
      end
    end.join " "
  end

  private

  def keys_prefixes_remove(key)
    key = key.gsub /^(s_|m_)/, ''
    key = key.gsub /^l_/,   "limit - "
    key = key.gsub /^sl_/,  "BLDC - "
    key = key.gsub /^foc_/, "FOC - "
    key = key.gsub /^s_/,   "speed - "
    key = key.gsub /^p_/,   "position - "
    key = key.gsub /^cc_/,  "current control - "
    key
  end
end
