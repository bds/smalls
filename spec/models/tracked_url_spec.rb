require 'rails_helper'

RSpec.describe TrackedUrl, type: :model do
  specify '#long_url' do
    expect(subject).to respond_to(:long_url)
  end

  specify '#slug' do
    expect(subject).to respond_to(:slug)
  end

  specify '#clicks' do
    expect(subject).to respond_to(:clicks)
  end

  specify '#short_url' do
    expect(subject).to respond_to(:short_url)
  end
end
