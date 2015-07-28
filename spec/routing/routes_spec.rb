require 'rails_helper'
require 'helpers/test_urls'

RSpec.describe 'URL shortener routes' do
  it 'has a named route' do
    expect(tracked_urls_path).to eq('/')
  end

  context 'creating a short url' do
    let(:long_url) { UrlHelpers.long_url }

    it 'routes requests and parameters to the correct controller' do
      expect(
        post(tracked_urls_path(long_url: long_url))
      ).to route_to(
        format: :json,
        controller: 'tracked_urls',
        action: 'create',
        long_url: long_url
      )
    end
  end

  context 'redirecting a short url' do
    let(:slug) { UrlHelpers.slug }

    it 'routes requests and parameters to the correct controller' do
      expect(
        get(tracked_url_path(slug))
      ).to route_to(
        format: :json,
        controller: 'tracked_urls',
        action: 'show',
        slug: slug
      )
    end
  end
end
