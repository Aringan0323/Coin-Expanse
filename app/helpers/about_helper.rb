module AboutHelper
  def self.highlight_instances(words, phrase)
    md = ''
    location = words.downcase.index(phrase.downcase)
    until location.nil?
      md += words[0, location]
      md += "<mark>#{words[location, phrase.size]}</mark>"
      words = words[location + phrase.size..-1]
      location = words.downcase.index(phrase.downcase)
    end
    md + words[location..]
  end
end
