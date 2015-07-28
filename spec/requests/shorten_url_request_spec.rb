require 'rails_helper'
require 'helpers/test_urls'

RSpec.describe 'URL shortener requests' do
  let(:parsed_response) do
    JSON.parse(response.body, symbolize_names: true)
  end

  describe 'creating a short url' do
    before do
      post(tracked_urls_path(long_url: long_url))
    end

    context 'POSTing a valid long URL' do
      let(:long_url) { UrlHelpers.long_url }

      it 'returns 200 OK' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns a short url' do
        expect(parsed_response.fetch(:short_url)).to be_short_url
      end
    end

    context 'POSTing an invalid URL' do
      let(:long_url) { UrlHelpers.invalid_character_in_host }

      it 'returns 400 Bad Request' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'redirecting a short url' do
    before do
      get(tracked_url_path(slug))
    end

    context 'Slug exists, URL is already tracked' do
      let(:slug) do
        tracked_link = UrlShortener.new(UrlHelpers.long_url).call!
        tracked_link.slug
      end

      it 'returns 301 Moved Permanently' do
        expect(response).to have_http_status(:moved_permanently)
      end
    end

    context 'Slug does not exist, URL is not tracked' do
      let(:slug) { UrlHelpers.slug }

      it 'returns 404 Not Found' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
