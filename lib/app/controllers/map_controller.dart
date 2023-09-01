import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';

class MapsController extends GetxController {
  var address = "null".obs;
  var autocompletePlace = "null".obs;
  var initialValue = Rx<Prediction?>(null);

  final TextEditingController controller = TextEditingController();

  void updateAutocompletePlace(PlacesDetailsResponse? result) {
    if (result != null) {
      autocompletePlace.value = result.result.formattedAddress ?? "";
    }
  }

  void updateAddress(PlacesDetailsResponse? value) {
    address.value = value?.result.formattedAddress ?? "";
  }

  void updateInitialValue(Prediction value) {
    autocompletePlace.value = value.structuredFormatting?.mainText ?? "";
    initialValue.value = value;
  }
  // MapLocationPicker? pickedLocation;
  // Future<void> pickLocation() async {
  //   MapLocationPicker(
  // apiKey: "AIzaSyAFY6EGZliOQ4Ovc_SD4x8BpFkerPmse6U",
  // onNext: (GeocodingResult? result);}
  //   //   MapLocationPicker result = await showLocationPicker(
  //   //     context,
  //   //     apiKey: 'YOUR_GOOGLE_MAPS_API_KEY_HERE',
  //   //     initialCenter: LatLng(37.4219999, -122.0840575), // Initial center of the map
  //   //     requiredGPS: true, // Require GPS to be enabled
  //   //     myLocationButtonEnabled: true, // Show "My Location" button
  //   //     layersButtonEnabled: true, // Show "Layers" button
  //   //   );

  //   //   if (result != null) {
  //   //     setState(() {
  //   //       pickedLocation = result;
  //   //     });
  //   //   }
  // }

  // void selectLocation(BuildContext context, MapLocationPicker result) {
  //   if (result != null) {
  //     final coordinates = result.currentLatLng;
  //     final latitude = coordinates?.latitude;
  //     final longitude = coordinates?.longitude;
  //     // Handle selected location
  //     print('Selected Location: $latitude, $longitude');
  //   }
  // }
}
