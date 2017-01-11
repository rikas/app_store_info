# coding: utf-8
module AppStoreInfo
  # Regions maps the App Store regions in different format.
  #
  # AppStoreInfo::Regions.full_list will return a list of countries in the following format:
  #   [{"Europe"=>
  #     [{:code=>"AL", :name=>"Albania"},
  #      {:code=>"AT", :name=>"Austria"},
  #      {:code=>"BY", :name=>"Belarus"},...
  #
  # AppStoreInfo::Regions::territory_list is a list of countries available on App Store:
  #
  #   {"AE"=>"United Arab Emirates",
  #    "AG"=>"Antigua and Barbuda",
  #    "AI"=>"Anguilla",
  #    "AL"=>"Albania",
  #    "AM"=>"Armenia",...
  class Regions
    # All the available regions (taken from https://developer.apple.com/library/ios/documentation/
    # LanguagesUtilities/Conceptual/iTunesConnect_Guide/Appendices/AppStoreTerritories.html
    TERRITORIES = {
      'AE' => 'United Arab Emirates',
      'AG' => 'Antigua and Barbuda', 'AI' => 'Anguilla', 'AL' => 'Albania', 'AM' => 'Armenia',
      'AO' => 'Angola', 'AR' => 'Argentina', 'AT' => 'Austria', 'AU' => 'Australia',
      'AZ' => 'Azerbaijan', 'BB' => 'Barbados', 'BE' => 'Belgium', 'BF' => 'Burkina Faso',
      'BG' => 'Bulgaria', 'BH' => 'Bahrain', 'BJ' => 'Benin', 'BM' => 'Bermuda',
      'BN' => 'Brunei Darussalam', 'BO' => 'Bolivia', 'BR' => 'Brazil', 'BS' => 'Bahamas',
      'BT' => 'Bhutan', 'BW' => 'Botswana', 'BY' => 'Belarus', 'BZ' => 'Belize', 'CA' => 'Canada',
      'CG' => 'Republic Of Congo', 'CH' => 'Switzerland', 'CL' => 'Chile', 'CM' => 'Cameroon',
      'CN' => 'China', 'CO' => 'Colombia', 'CR' => 'Costa Rica', 'CV' => 'Cape Verde',
      'CY' => 'Cyprus', 'CZ' => 'Czech Republic', 'DE' => 'Germany', 'DK' => 'Denmark',
      'DM' => 'Dominica', 'DO' => 'Dominican Republic', 'DZ' => 'Algeria', 'EC' => 'Ecuador',
      'EE' => 'Estonia', 'EG' => 'Egypt', 'ES' => 'Spain', 'ET' => 'Ethiopia', 'FI' => 'Finland',
      'FJ' => 'Fiji', 'FM' => 'Federated States Of Micronesia', 'FR' => 'France',
      'GB' => 'United Kingdom', 'GD' => 'Grenada', 'GH' => 'Ghana', 'GM' => 'Gambia',
      'GR' => 'Greece', 'GT' => 'Guatemala', 'GW' => 'Guinea-Bissau', 'GY' => 'Guyana',
      'HK' => 'Hong Kong', 'HN' => 'Honduras', 'HR' => 'Croatia', 'HU' => 'Hungary',
      'ID' => 'Indonesia', 'IE' => 'Ireland', 'IL' => 'Israel', 'IN' => 'India', 'IS' => 'Iceland',
      'IT' => 'Italy', 'JM' => 'Jamaica',
      'JO' => 'Jordan', 'JP' => 'Japan', 'KE' => 'Kenya', 'KG' => 'Kyrgyzstan', 'KH' => 'Cambodia',
      'KN' => 'St. Kitts and Nevis', 'KR' => 'Republic Of Korea', 'KW' => 'Kuwait',
      'KY' => 'Cayman Islands', 'KZ' => 'Kazakhstan', 'LA' => "Lao People's Democratic Republic",
      'LB' => 'Lebanon', 'LC' => 'Santa Lucia', 'LK' => 'Sri Lanka', 'LR' => 'Liberia',
      'LS' => 'Lesotho', 'LT' => 'Lithuania', 'LU' => 'Luxembourg', 'LV' => 'Latvia',
      'MD' => 'Republic Of Moldova', 'MG' => 'Madagascar', 'MK' => 'Macedonia', 'ML' => 'Mali',
      'MN' => 'Mongolia', 'MO' => 'Macau', 'MR' => 'Mauritania', 'MS' => 'Montserrat',
      'MT' => 'Malta', 'MU' => 'Mauritius', 'MW' => 'Malawi', 'MX' => 'Mexico', 'MY' => 'Malaysia',
      'MZ' => 'Mozambique', 'NA' => 'Namibia', 'NE' => 'Niger', 'NG' => 'Nigeria',
      'NI' => 'Nicaragua', 'NL' => 'Netherlands', 'NO' => 'Norway', 'NP' => 'Nepal',
      'NZ' => 'New Zealand', 'OM' => 'Oman', 'PA' => 'Panama', 'PE' => 'Peru',
      'PG' => 'Papua New Guinea', 'PH' => 'Philippines', 'PK' => 'Pakistan', 'PL' => 'Poland',
      'PT' => 'Portugal', 'PW' => 'Palau', 'PY' => 'Paraguay', 'QA' => 'Qatar', 'RO' => 'Romania',
      'RU' => 'Russia', 'RW' => 'Rwanda', 'SA' => 'Saudi Arabia', 'SB' => 'Solomon Islands',
      'SC' => 'Seychelles', 'SE' => 'Sweden', 'SG' => 'Singapore',
      'SI' => 'Slovenia', 'SK' => 'Slovakia', 'SL' => 'Sierra Leone',
      'SN' => 'Senegal', 'SR' => 'Suriname', 'SS' => 'South Sudan',
      'ST' => 'Sao Tome and Principe', 'SV' => 'El Salvador', 'SZ' => 'Swaziland',
      'TC' => 'Turks and Caicos', 'TD' => 'Chad', 'TH' => 'Thailand', 'TJ' => 'Tajikistan',
      'TM' => 'Turkmenistan', 'TN' => 'Tunisia', 'TR' => 'Turkey', 'TT' => 'Trinidad and Tobago',
      'TW' => 'Taiwan', 'TZ' => 'Tanzania', 'UA' => 'Ukraine', 'UG' => 'Uganda',
      'US' => 'United States', 'UY' => 'Uruguay', 'UZ' => 'Uzbekistan',
      'VC' => 'St. Vincent and The Grenadines', 'VE' => 'Venezuela',
      'VG' => 'British Virgin Islands', 'VN' => 'Vietnam', 'YE' => 'Yemen',
      'ZA' => 'South Africa', 'ZM' => 'Zambia', 'ZW' => 'Zimbabwe'
    }.freeze

    REGIONS = {
      'Europe' => %w(
        AL AT BY BE BG HR CY CZ DK EE FI FR DE GR HU IS IE IT LV LT LU MK MT MD NL NO PL PT RO RU
        SK SI ES SE CH TR UA GB
      ),

      'Africa, Middle East, and India' => %w(
        DZ AO AM AZ BH BJ BW BF CM CV TD CG EG ET GM GH GW IN IL JO KE KW LB LS LR MG MW ML MR MU
        MZ NA NE NG OM QA RW SA SN SC SS SL ZA SZ ST TZ TN UG AE YE ZM ZW
      ),

      'Latin America and the Caribbean' => %w(
        AI AG AR BS BB BZ BM BO BR KY CL CO CR DM DO EC SV GD GT GY HN JM MX MS NI PA PY PE LC KN
        VC SR TT TC UY VE VG
      ),

      'Asia Pacific' => %w(
        AU BT BN KH CN FJ HK ID JP KZ KR KG LA MO MY FM MN NP NZ PK PW PG PH SG SB LK TW TJ TH TM
        UZ VN
      ),

      'The United States and Canada' => %w(CA US)
    }

    # Find a territory by code.
    #
    #   AppStoreInfo::Regions.find('PT')
    #   # => "Portugal"
    def self.find(code)
      territory_list[code.upcase]
    end

    def self.full_list
      REGIONS.map do |region|
        { region.first => region.last.map { |code| { code: code, name: TERRITORIES[code] } } }
      end
    end

    def self.territory_list
      TERRITORIES
    end
  end
end
