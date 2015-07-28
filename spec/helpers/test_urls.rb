module UrlHelpers
  def self.long_url
    'https://archive.org/details/301works-faq'
  end

  def self.invalid_character_in_host
    'http://[<invalid]/'
  end

  def self.short_url
    "https://#{ENV['HOSTNAME']}/ITxJHQ"
  end

  def self.slug
    'ITxJHQ'
  end
end
