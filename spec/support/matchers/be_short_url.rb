RSpec::Matchers.define :be_short_url do |expected|
  match do |actual|
    begin
      uri = Addressable::URI.parse(actual)
      uri.scheme && uri.host && uri
    rescue URI::InvalidURIError
      false
    end
  end
end
