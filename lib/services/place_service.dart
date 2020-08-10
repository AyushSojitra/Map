import 'dart:async';

import '../models/place_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlacesService {
  static final _service = new PlacesService();

  static PlacesService get() {
    return _service;
  }

  final String searchUrl =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=33.8670,151.1957&radius=500&key=AIzaSyBaPFHgj5hYDQurwV5sYe7rhU3CsQ5u_mM";

  Future<List<Place>> getNearbyPlaces() async {
    var response =
        await http.get(searchUrl, headers: {"Accept": "application/json"});
    var places = <Place>[];

    List data = json.decode(response.body)["results"];

    data.forEach((f) => places.add(new Place(f["icon"], f["name"],
        f["rating"].toString(), f["vicinity"], f["place_id"])));
    return places;
  }
}
