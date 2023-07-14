import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/hotel.dart';
import '../models/hotelDetails.dart';
import '../models/region.dart';
import '../models/tripDetails.dart';

class ApiCalls {
  Map<String, String> requestHeaders = {
    'X-RapidAPI-Key': '8e22765ce0msh1d8ed1e7f63ced5p1ed632jsn44bef392d37c',
    'X-RapidAPI-Host': 'hotels-com-provider.p.rapidapi.com',
  };

  Future<Region> getRegionId(String city) async {
    String baseURL = 'https://hotels-com-provider.p.rapidapi.com/v2/regions';

    Map<String, String> queryParams = {
      'domain': 'SG',
      'locale': 'en_SG',
      'query': city,
    };

    String queryString = Uri(queryParameters: queryParams).query;
    final response = await http.get(Uri.parse(baseURL + '?' + queryString),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      //TODO return first element in data[] as Region object
      return Region.fromJson(jsonDecode(response.body)['data'][0]);
    } else {
      throw Exception('Failed to load regions');
    }
  }

  Future<List<Hotel>> fetchHotels(TripDetails tripDetails) async {
    //   used to fetch hotels in the region
    String baseURL =
        'https://hotels-com-provider.p.rapidapi.com/v2/hotels/search';

    Map<String, String> queryParams = {
      'domain': 'SG',
      'locale': 'en_SG',
      'sort_order': 'RECOMMENDED',
      'checkout_date': tripDetails.checkOut,
      'region_id': tripDetails.regionId,
      'adults_number': (tripDetails.adults).toString(),
      'checkin_date': tripDetails.checkOut,
    };
    String queryString = Uri(queryParameters: queryParams).query;
    final response = await http.get(Uri.parse(baseURL + '?' + queryString),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      List<dynamic> jsonList =
          jsonDecode(response.body)['properties'] as List<dynamic>;
      List<Hotel> hotel = jsonList.map((json) => Hotel.fromJson(json)).toList();
      return hotel;
    } else {
      throw Exception('Failed to load regions');
    }
  }

  Future<HotelDetails> fetchHotelDetails(String id) async {
    String baseURL =
        'https://hotels-com-provider.p.rapidapi.com/v2/hotels/details';

    Map<String, String> queryParams = {
      'domain': 'SG',
      'locale': 'en_SG',
      'hotel_id': id,
    };

    String queryString = Uri(queryParameters: queryParams).query;
    final response = await http.get(Uri.parse(baseURL + '?' + queryString),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      return HotelDetails.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load regions');
    }
  }
}
