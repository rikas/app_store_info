# coding: utf-8
require 'spec_helper'

describe AppStoreInfo do
  let(:gleam) { 'https://itunes.apple.com/us/app/gleam-inspiration/id599015198' }
  let(:hstone) { 'https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=625257520' }
  let(:birds) { 'https://itunes.apple.com/gb/app/angry-birds/id343200656?mt=8' }
  let(:birds2) { 'https://itunes.apple.com/en/app/angry-birds/id343200656?mt=8' }
  let(:coach) { 'https://itunes.apple.com/us/app/coacher-soccer-coaching-software/id918079650' }
  let(:videos) { 'https://itunes.apple.com/us/app/zaps-share-videos-by-location/id975333802?mt=8' }
  let(:moto) { 'https://itunes.apple.com/us/app/moto-x-mayhem/id323438913?mt=8' }
  let(:bogus) { 'https://itunes.apple.com/us/app/bogus/id0909099090990909?mt=8' }
  let(:osx) { 'https://itunes.apple.com/pt/app/slack/id803453959?mt=12' }
  let(:flooz) { 'https://itunes.apple.com/fr/app/flooz/id940393916' }
  let(:flooz_wrong_region) { 'https://itunes.apple.com/pt/app/flooz/id940393916' }
  let(:bad) { 'https://www.google.pt/?gws_rd=ssl#q=http://itunes.apple.com' }
  let(:loisir) do
    'https://itunes.apple.com/app/apple-store/id987860898?pt=110416813&ct=le-www-footer&mt=8'
  end

  it 'has a version number' do
    expect(AppStoreInfo::VERSION).not_to be nil
  end

  describe '.read' do
    it 'raises error if the app is not available on a particular region' do
      VCR.use_cassette('flooz_wrong_region') do
        message = "App not found or unavailable on 'pt' region"
        expect do
          described_class.read_url(flooz_wrong_region)
        end.to raise_error(AppStoreInfo::EntryNotFound, message)
      end
    end
  end

  describe '.read_url' do
    it 'fails if the url is not from Apple Store with ArgumentError' do
      expect { described_class.read_url(bad) }.to raise_error(AppStoreInfo::InvalidURLError)
    end

    it 'fails if the url is offline with ConnectionError' do
      stub_request(:get, /itunes\.apple\.com/).to_return(status: 404, body: '{}')

      expect { described_class.read_url(moto) }.to raise_error(AppStoreInfo::ConnectionError)
    end

    it 'fails if the app cannot be found with EntryNotFound' do
      stub_request(:get, /itunes\.apple\.com/).to_return(status: 200, body: '{}')

      expect { described_class.read_url(bogus) }.to raise_error(AppStoreInfo::EntryNotFound)
    end

    it 'fails if the url is from an unknown app' do
      VCR.use_cassette('bogus_app') do
        expect { described_class.read_url(bogus) }.to raise_error(AppStoreInfo::EntryNotFound)
      end
    end

    it 'fails if the url is not from a mobile app' do
      VCR.use_cassette('desktop_slack') do
        expect { described_class.read_url(osx) }.to raise_error(AppStoreInfo::EntryNotFound)
      end
    end

    it 'returns the right info when domain is not present' do
      VCR.use_cassette('gleam') do
        response = described_class.read_url(gleam)

        expect(response.id).to eq(599_015_198)
        expect(response.name).to eq('Gleam - your fashion app for inspiration and shopping')
      end
    end

    it 'returns the right info when "id" is in the name' do
      VCR.use_cassette('zaps') do
        response = described_class.read_url(videos)

        expect(response.id).to eq(975_333_802)
        expect(response.name).to eq('ZAPS - Share Videos by Location')
        expect(response.url).to eq('http://idtapth.at')
      end
    end

    it 'returns the right info when using a different type of URL' do
      VCR.use_cassette('hearthstone') do
        response = described_class.read_url(hstone)

        expect(response.id).to eq(625_257_520)
        expect(response.name).to eq('Hearthstone: Heroes of Warcraft')
        expect(response.url).to eq('http://us.battle.net/hearthstone/en/')
      end
    end

    it 'returns the right info when the app is available on ipad and iphone' do
      VCR.use_cassette('angry_birds') do
        response = described_class.read_url(birds)

        expect(response.id).to eq(343_200_656)
        expect(response.name).to eq('Angry Birds')
        expect(response.url).to eq('http://www.angrybirds.com/')
      end
    end

    it 'returns the right info when the app url has en as country' do
      VCR.use_cassette('angry_birds2') do
        response = described_class.read_url(birds2)

        expect(response.id).to eq(343_200_656)
        expect(response.name).to eq('Angry Birds')
        expect(response.url).to eq('http://www.angrybirds.com/')
      end
    end

    it 'returns the right info when the app is available on ipad only' do
      VCR.use_cassette('coacher') do
        response = described_class.read_url(coach)

        expect(response.id).to eq(918_079_650)
        expect(response.name).to eq('Coacher - Soccer Coaching Software')
        expect(response.url).to eq('http://www.joincoacher.com')
      end
    end

    it 'returns the right info when the app is available on a particular country only' do
      VCR.use_cassette('flooz') do
        response = described_class.read_url(flooz)

        expect(response.id).to eq(940_393_916)
        expect(response.name).to eq('Flooz - Paiement entre amis gratuit fun et securisé France')
        expect(response.url).to eq('https://www.flooz.me')
        expect(response.currency).to eq('EUR')
      end
    end

    it 'returns the right info when the link has no country info' do
      VCR.use_cassette('loisir') do
        response = described_class.read_url(loisir)

        expect(response.id).to eq(987_860_898)
        expect(response.name).to eq('Loisirs Enchères')
        expect(response.url).to eq('http://www.loisirsencheres.com/content/merchant')
        expect(response.currency).to eq('USD')
      end
    end
  end
end
