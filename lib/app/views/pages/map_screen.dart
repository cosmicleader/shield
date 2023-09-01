import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:shield/app/controllers/map_controller.dart';

class MapScreen extends GetView<MapsController> {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('World Map'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PlacesAutocomplete(
              searchController: controller.controller,
              apiKey: "AIzaSyAFY6EGZliOQ4Ovc_SD4x8BpFkerPmse6U",
              mounted: true,
              hideBackButton: false,
              onGetDetailsByPlaceId: controller.updateAutocompletePlace,
            ),
            OutlinedButton(
              child: Text('show dialog'.toUpperCase()),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Example'),
                      content: PlacesAutocomplete(
                        apiKey: "AIzaSyAFY6EGZliOQ4Ovc_SD4x8BpFkerPmse6U",
                        searchHintText: "Search for a place",
                        mounted: true,
                        hideBackButton: false,
                        initialValue: controller.initialValue.value,
                        onSuggestionSelected: (value) {
                          controller.updateInitialValue(value);
                        },
                        onGetDetailsByPlaceId: controller.updateAddress,
                      ),
                      // actions: <Widget>[
                      // TextButton(
                      // child: const Text('Done'),
                      // onPressed: () => Navigator.of(context).pop(),
                      // ),
                      // ],
                    );
                  },
                );
              },
            ),
          ]),
    );
  }
}
