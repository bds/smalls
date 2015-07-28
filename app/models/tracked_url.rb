class TrackedUrl < ActiveRecord::Base
  validates :long_url, presence: true
  validates :slug, presence: true, length: { maximum: 14 }

  def short_url
    "http://#{ENV['HOSTNAME']}/#{slug}"
  end
end
