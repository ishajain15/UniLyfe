import 'dart:convert';
import 'package:http/http.dart';

class Place {
  Place(
      {this.streetNumber, this.street, this.city, this.zipCode, this.placeId});

  String streetNumber;
  String street;
  String city;
  String zipCode;
  String placeId;

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode, placeId: $placeId)';
  }
}

class Suggestion {
  Suggestion(this.placeId, this.description);

  final String placeId;
  final String description;

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  PlaceApiProvider(this.sessionToken);

  final client = Client();

  final sessionToken;

  static final String androidKey = 'YOUR_API_KEY_HERE';
  static final String iosKey = 'YOUR_API_KEY_HERE';
  final apiKey = 'AIzaSyBW_0mCRvtAq9Pb5KxbsxznM7lgM06kjic';

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=establishment&language=$lang&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
            result['result']['address_components'] as List<dynamic>;
        // build result
        final place = Place();
        components.forEach((c) {
          final List type = c['types'];
          if (type.contains('street_number')) {
            place.streetNumber = c['long_name'];
          }
          if (type.contains('route')) {
            place.street = c['long_name'];
          }
          if (type.contains('locality')) {
            place.city = c['long_name'];
          }
          if (type.contains('postal_code')) {
            place.zipCode = c['long_name'];
          }

          place.placeId = placeId;
        });
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
