import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:google_map_polyline_new/google_map_polyline_new.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_logistics/repos/crud_iterface.dart';

mixin GeolocationOperation on CrudInterface {
  static const _apiKey = 'AIzaSyCgSuhMw39F8Pvh1oHXOl1itj-_KbO-01Q';
  GoogleMapPolyline googleMapPolyline = new GoogleMapPolyline(apiKey: _apiKey);

  // Object for PolylinePoints
  late PolylinePoints polylinePoints;

  Future<List<Polyline>> createPolylines (
      {required LatLng startPoint, required LatLng endPoint}) async {
    final List<Polyline> polyline = [];
    List<LatLng> routeCoords = [];

    try {
      var result= await googleMapPolyline.getCoordinatesWithLocation(
          origin: startPoint, destination: endPoint, mode: RouteMode.driving);
      print(result!.length.toString()+"fffffffffffffff");
      routeCoords.addAll(result);


        polyline.add(Polyline(
            polylineId: PolylineId('iter'),
            visible: true,
            points: routeCoords,
            width: 4,
            color: Colors.blue,
            startCap: Cap.roundCap,
            endCap: Cap.buttCap));

        return polyline;

    } catch (e) {
      print(e);
      throw e.toString();
    }
  }
}
