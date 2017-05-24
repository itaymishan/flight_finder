require 'net/http'
require 'net/https'
require 'byebug'
require 'awesome_print'
require 'json'
require 'time'


class Wow

  def search(from = 'YYZ', to = 'TLV', start_date = DateTime.now, end_date = DateTime.now + 365)
    arr = []
    cur_date = start_date
    while cur_date < end_date do
      sleep(3)
      req_params = params
      req_params[:departDateFrom] = format_date(cur_date)
      req_params[:departDateTo] = format_date(cur_date + 7)
      req_params[:arrivalDateFrom] = format_date(cur_date + 14)
      req_params[:arrivalDateTo] = format_date(cur_date + 21)
      puts req_params
      arr << fetch_flights(req_params)
      cur_date += 10
    end
  end

  def fetch_flights(params)
    uri = URI('https://booking.wowair.com/api/midgardur/v2/flight')
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    # puts res.body if res.is_a?(Net::HTTPSuccess)
    extract_details(JSON.parse(res.body)['flights']) unless res.body['flights'] == nil
  end

  def format_date(datetime)
    datetime.strftime("%F")
  end

  def extract_details(flights)
    return nil if flights.empty? || flights.nil?
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
    arrivalDateTo: '2017-10-21',
    arrivalDateFrom: '2017-10-15',
    departDateFrom: '2017-10-01',
    departDateTo: '2017-10-03',
    currency: 'CAD',
    toCityCode:'TLV',
    destination: 'TLV',
    fromCityCode: 'YYZ',
    origin:'YYZ',
    fareTypeCategories: 1,
    useFlexDates: true,
    fareTypeCategory: 1,
    infants: 0,
    culture: 'us',
    lang: 'en_CA',
    interline: false,
    roundTrip: true,
    adults: 1,
    promocode: '',
    children: 0
  }
  end
end

Wow.new.search
