class UrlShortener
  attr_reader :url

  def initialize(url)
    @url = parse_url(url)
  end

  def call!
    return TrackedUrl.find_by(slug: slug) if TrackedUrl.exists?(slug: slug)
    TrackedUrl.create!(long_url: url.to_s, slug: slug)
  end

  private

  # https://github.com/technoweenie/guillotine/blob/master/lib/guillotine.rb
  #
  # Author: Rick Olson
  #
  # Shortens a given URL to a short code.
  #
  # 1) MD5 hash the URL to the hexdigest
  # 2) Convert it to a Bignum
  # 3) Pack it into a bitstring as a big-endian int
  # 4) base64-encode the bitstring, remove the trailing junk
  #
  # Returns a unique String code for the URL.
  def slug
    @slug ||= begin
      Base64.urlsafe_encode64(
        [Digest::MD5.hexdigest(url).to_i(16)].pack("N")
      ).sub(/==\n?$/, '')
    end
  end

  def parse_url(url)
    url.gsub!(/\s/, '')
    Addressable::URI.parse(url)
  end
end
