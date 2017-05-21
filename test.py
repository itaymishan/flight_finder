import requests

def main():
    resp = requests.get('https://booking.wowair.com/api/midgardur/v2/flight?customerSessionGuid=61f640rfw549nfs3r062sux4ma2b97c2cc0583886945&iataNum=&arrivalDateTo=2017-10-21&isCampaignSearch=false&fromCityCode=YYZ&fareTypeCategories=1&useFlexDates=true&apiKey=&fareTypeCategory=1&origin=YYZ&allInclusive=undefined&departDateFrom=2017-10-01&infants=0&destination=TLV&culture=us&lang=en_CA&returnDateString=2017-10-18&interline=false&iataUser=&currency=CAD&arrivalDateFrom=2017-10-15&departureDateString=2017-10-08&toCityCode=TLV&roundTrip=true&iataPass=&adults=1&promocode=&departDateTo=2017-10-10&children=0')
    print(resp.content)

if __name__ == '__main__':
    main()