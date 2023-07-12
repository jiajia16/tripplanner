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
      final responseData = jsonDecode(response.body);
      final data = responseData['data'];

      final firstRegionData = data[0];
      final regionId = firstRegionData['regionId'];
      final regionName = firstRegionData['regionName'];
      final country = firstRegionData['country'];

      return Region(regionId: '', regionName: '', country: '');
    } else {
      throw Exception('Failed to load regions');
    }
  }

  void fetchHotels(TripDetails tripDetails) async {
    Map<String, dynamic> queryParams = {
      'regionId': tripDetails.regionId,
      'regionName': tripDetails.regionName,
      'country': tripDetails.country,
      'checkIn': tripDetails.checkIn,
      'checkOut': tripDetails.checkOut,
      'adults': tripDetails.adults,
    };

    //TODO
  }

  void fetchHotelDetails(String id) async {
    HotelDetails hotelDetails = HotelDetails.fromJson({});
    String id = hotelDetails.id;
    fetchHotelDetails(id);
    //TODO
  }
}
