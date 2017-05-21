require 'net/http'
require 'net/https'
require 'byebug'
require "awesome_print"
require 'json'


class Wow
  def fetch_flights
    uri = URI('https://booking.wowair.com/api/midgardur/v2/flight')
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)    
    # puts res.body if res.is_a?(Net::HTTPSuccess)
    extract_details(JSON.parse(res.body)['flights'])
  end

  def extract_details(flights)    
    flights.map do |flight|
      {
          origin: flight['originShortName'],
          destination: flight['destinationShortName'],
          fares: flight['fares'].map{|fare| fare['fareWithTaxes']},
          dep_date: flight['departureTime']
      }
    end
  end

  def params
  {
    customerSessionGuid: '61f640rfw549nfs3r062sux4ma2b97c2cc0583886945',
    iataNum: '',
    arrivalDateTo: '2017-10-21',
    arrivalDateFrom: '2017-10-15',
    departureDateString: '2017-10-08',
    returnDateString: '2017-10-18',
    departDateFrom: '2017-10-01',
    departDateTo: '2017-10-10',
    currency: 'CAD',
    toCityCode:'TLV',
    destination: 'TLV',
    fromCityCode: 'YYZ',
    origin:'YYZ',
    isCampaignSearch: false,
    fareTypeCategories: 1,
    useFlexDates: true,
    apiKey: '',
    fareTypeCategory: 1,
    allInclusive: 'undefined',
    infants: 0,
    culture: 'us',
    lang: 'en_CA',
    interline: false,
    iataUser: '',
    roundTrip: true,
    iataPass: '',
    adults: 1,
    promocode: '',
    children: 0
  }
  end
end

Wow.new.fetch_flights