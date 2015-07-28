require 'rails_helper'
require 'helpers/test_urls'

describe UrlShortener do
  let(:url)     { UrlHelpers.long_url }
  let(:bad_url) { UrlHelpers.invalid_character_in_host }

  describe '#new' do
    context 'when a given a valid URL' do
      it 'creates a new UrlShortener instance' do
        expect(described_class.new(url)).to be_a(UrlShortener)
      end
    end

    context 'when give a URL with an invalid character in host' do
      it 'raises an exception' do
        expect { described_class.new(bad_url) }.to raise_exception(
          Addressable::URI::InvalidURIError
        )
      end
    end
  end

  describe '#call!' do
    it 'returns a TrackedUrl' do
      expect(described_class.new(url).call!).to be_a(TrackedUrl)
    end
  end
end
