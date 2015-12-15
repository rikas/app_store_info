require 'spec_helper'

describe App do
  let(:universal) { described_class.new(json_read('universal.json')) }
  let(:ipad) { described_class.new(json_read('ipad.json')) }
  let(:iphone) { described_class.new(json_read('iphone.json')) }

  context 'iOS Universal app' do
    it 'reads the parameters correctly' do
      expect(universal.id).to eq(306934924)
      expect(universal.name).to eq('Universal app')
      expect(universal.url).to eq('http://universal.com')
      expect(universal.average_user_rating).to eq(4.0)
      expect(universal.user_rating_count).to eq(93200)
      expect(universal.genre_ids).to include('6023', '6003')
      expect(universal.price).to eq(2.0)
      expect(universal.currency).to eq('USD')
      expect(universal.supported_devices).to include(
        'iPad2Wifi', 'iPad23G', 'iPhone4S',
        'iPadThirdGen', 'iPadThirdGen4G', 'iPhone5', 'iPodTouchFifthGen', 'iPadFourthGen',
        'iPadFourthGen4G', 'iPadMini', 'iPadMini4G', 'iPhone5c', 'iPhone5s', 'iPhone6',
        'iPhone6Plus', 'iPodTouchSixthGen')
      expect(universal.company).to eq('Universal apps, Inc.')
      expect(universal.description).to eq('The app description')
      expect(universal.minimum_os_version).to eq('8.0')
      expect(universal.features).to eq(['iosUniversal'])
      expect(universal.languages).to eq(%w(CA EN FR DE ID IT JA KO PT RU ES TH TR))
    end

    it 'reads the current version parameters correctly' do
      expect(universal.current_version).to_not be_nil

      current = universal.current_version

      expect(current.average_user_rating).to eq(4.5)
      expect(current.user_rating_count).to eq(53)
      expect(current.number).to eq('9.7')
      expect(current.release_notes).to eq('Bug fix')
    end

    describe '#universal?' do
      it 'returns true' do
        expect(universal.universal?).to be_truthy
      end
    end

    describe '#store_icon_url' do
      it 'returns the correct icon' do
        expect(universal.store_icon_url).to eq('http://artwork2.jpg')
      end
    end
  end

  context 'iPhone app' do
    it 'reads the parameters correctly' do
      expect(iphone.id).to eq(284708449)
      expect(iphone.name).to eq('Urbanspoon')
      expect(iphone.url).to eq('http://www.zomato.com/mobile')
      expect(iphone.average_user_rating).to eq(3.5)
      expect(iphone.user_rating_count).to eq(236824)
      expect(iphone.genre_ids).to include('6023', '6003')
      expect(iphone.price).to eq(0.0)
      expect(iphone.currency).to eq('USD')
      expect(iphone.supported_devices).to include(
        'iPad2Wifi', 'iPad23G', 'iPhone4S',
        'iPadThirdGen', 'iPadThirdGen4G', 'iPhone5', 'iPodTouchFifthGen', 'iPadFourthGen',
        'iPadFourthGen4G', 'iPadMini', 'iPadMini4G', 'iPhone5c', 'iPhone5s', 'iPhone6',
        'iPhone6Plus', 'iPodTouchSixthGen')
      expect(iphone.company).to eq('Zomato Media Pvt. Ltd.')
      expect(iphone.description).to eq('Urbanspoon (by Zomato) for iPhone is the #1 FREE app.')
      expect(iphone.minimum_os_version).to eq('6.0')
      expect(iphone.features).to eq([])
      expect(iphone.languages).to eq(['EN'])
    end

    it 'reads the current version parameters correctly' do
      expect(iphone.current_version).to_not be_nil

      current = iphone.current_version

      expect(current.average_user_rating).to eq(2.0)
      expect(current.user_rating_count).to eq(413)
      expect(current.number).to eq('3.5.422')
      expect(current.release_notes).to eq('* Bug fixes and performace improvements')
    end

    describe '#universal?' do
      it 'returns false' do
        expect(iphone.universal?).to be_falsy
      end
    end

    describe '#store_icon_url' do
      it 'returns the correct icon' do
        expect(universal.store_icon_url).to eq('http://artwork2.jpg')
      end
    end
  end

  context 'iPad app' do
    it 'reads the parameters correctly' do
      expect(ipad.id).to eq(918079650)
      expect(ipad.name).to eq('iPad app')
      expect(ipad.url).to eq('http://www.joinipad.com')
      expect(ipad.average_user_rating).to eq(3.5)
      expect(ipad.user_rating_count).to eq(14)
      expect(ipad.genre_ids).to include('6004', '6002')
      expect(ipad.price).to eq(0.0)
      expect(ipad.currency).to eq('EUR')
      expect(ipad.supported_devices).to include(
        'iPad2Wifi', 'iPad23G', 'iPadThirdGen',
        'iPadThirdGen4G', 'iPadFourthGen', 'iPadFourthGen4G', 'iPadMini', 'iPadMini4G')
      expect(ipad.company).to eq('iPad apps LTD')
      expect(ipad.description).to eq('My super iPad app!')
      expect(ipad.minimum_os_version).to eq('7.0')
      expect(ipad.features).to eq([])
      expect(ipad.languages).to eq(['EN', 'PT', 'ES'])
    end

    it 'reads the current version parameters correctly' do
      expect(ipad.current_version).to_not be_nil

      current = ipad.current_version

      expect(current.average_user_rating).to be_nil
      expect(current.user_rating_count).to be_nil
      expect(current.number).to eq('1.6')
      expect(current.release_notes).to eq("Bug fixes\nNew interface")
    end

    describe '#universal?' do
      it 'returns false' do
        expect(ipad.universal?).to be_falsy
      end
    end

    describe '#store_icon_url' do
      it 'returns the correct icon' do
        expect(universal.store_icon_url).to eq('http://artwork2.jpg')
      end
    end
  end
end
