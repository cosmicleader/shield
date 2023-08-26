import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shield/app/views/themes/colours.dart';

import '../../controllers/guides_controller.dart';

class GuidesPage extends GetView<GuidesController> {
  const GuidesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // controller.loadData();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const BackButton(),
                      Text(
                        'Back',
                        style: GoogleFonts.inter(color: kBlack),
                      ),
                    ],
                  ),
                  controller.obx(
                    (state) {
                      // final selectedGuide = controller.selectedCategory.value;
                      // log('guides page line 38 ${selectedGuide?.name}');

                      log(controller.categoryMap.values.toString());
                      return DropdownButton<String>(
                        value: controller.selectedCategory.value.name,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.changeCategory(newValue);
                          }
                        },
                        items: controller.dropDownOptions
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        // items: controller.allListData
                        //     .map<DropdownMenuItem<String>>((e) =>
                        //         DropdownMenuItem(
                        //             value: e.name, child: Text(e.name)))
                        //     .toList(),
                      );
                    },
                    onLoading: const Center(child: CircularProgressIndicator()),
                    onError: (error) => Center(child: Text('Error: $error')),
                  ),
                  // Obx(
                  //   () => DropdownButton<String>(
                  // items: controller.allListData
                  //     .map<DropdownMenuItem<String>>((e) =>
                  //         DropdownMenuItem(
                  //             value: e.name, child: Text(e.name)))
                  //     .toList(),
                  //     value: controller.selectedCategory.value != null
                  //         ? controller.selectedCategory.value.id
                  //         : null,
                  //     onChanged: (String? newValue) {
                  //       if (newValue != null) {
                  //         controller.changeCategory(newValue);
                  //       }
                  //     },
                  //   ),
                  // ),
                ],
              ),
              Text(
                'WHEN DISASTER STRIKES,\nKNOW TO ESCAPE',
                style: GoogleFonts.inter(
                    color: kBlack.withOpacity(0.5), fontSize: 24),
              ),
              Expanded(
                child: controller.obx(
                  (state) {
                    final selectedGuide = controller.selectedCategory.value;
                    return ListView.builder(
                      itemCount: selectedGuide.elements.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            selectedGuide.elements[index].description,
                          ),
                        );
                      },
                    );
                  },
                  onLoading: const Center(child: CircularProgressIndicator()),
                  onError: (error) => Center(child: Text('Error: $error')),
                ),
                // child: Obx(() {
                //   if (controller.allListData.isEmpty) {
                //     return Center(
                //       child: CircularProgressIndicator(),
                //     );
                //   } else {
                //     final selectedGuide = controller.selectedCategory.value;
                //     return ListView.builder(
                //       itemCount: selectedGuide != null
                //           ? selectedGuide.elements.length
                //           : 0,
                //       itemBuilder: (BuildContext context, int index) {
                //         return ListTile(
                //           title: Text(
                //             selectedGuide?.elements[index]?.description ?? '',
                //           ),
                //         );
                //       },
                //     );
                //   }
                // }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shield/app/views/themes/colours.dart';

// import '../../controllers/guides_controller.dart';
// // import '../../models/guides_model.dart';
// import '../../models/guides_model.dart';
// import '../../services/data_service.dart';

// class GuidesPage extends GetView<GuidesController> {
//   const GuidesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // final category = [allListData.first.name];
//     // controller.loadHashMap();
//     return SafeArea(
//       child: Scaffold(
//         // appBar: AppBar(title: const Text('Guides Page')),
//         body: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       BackButton(),
//                       Text(
//                         'Back',
//                         style: GoogleFonts.inter(color: kBlack),
//                       ),
//                     ],
//                   ),
//                   Obx(() => DropdownButton<String>(
//                         value: controller.selectedCategory.value != null
//                             ? controller.selectedCategory.value.name
//                             : null,
//                         onChanged: (String? newValue) {
//                           if (newValue != null) {
//                             controller.changeCategory(newValue);
//                           }
//                         },
//                         items: controller.categoryMap.values
//                             .map<DropdownMenuItem<String>>((Guides guide) {
//                           return DropdownMenuItem<String>(
//                             value: guide.name,
//                             child: Text(guide.name),
//                           );
//                         }).toList(),
//                       )),
//                 ],
//               ),
//               Text(
//                 'WHEN DISASTER STRIKES,\nKNOW TO ESCAPE',
//                 style: GoogleFonts.inter(
//                     color: kBlack.withOpacity(0.5), fontSize: 24),
//               ),
//               Expanded(
//                 child: Obx(() {
//                   if (controller.allListData.isEmpty) {
//                     return Center(
//                       child:
//                           CircularProgressIndicator(), // Show loading indicator
//                     );
//                   } else {
//                     return ListView.builder(
//                       itemCount:
//                           controller.selectedCategory.value.elements.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return ListTile(
//                           title: Text(
//                             controller.selectedCategory.value.elements[index]
//                                 .description
//                                 .toString(),
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 }),
//               ),
//               // Expanded(
//               //   child: Obx(() => ListView.builder(
//               //         itemCount:
//               //             (controller.selectedCategory.value.elements.length),
//               //         itemBuilder: (BuildContext context, int index) {
//               //           // final listData = allListData[index];
//               //           return ListTile(
//               //               title: Text(
//               //             controller.selectedCategory.value.elements[index]
//               //                 .description
//               //                 .toString(),
//               //             // title: Text(controller
//               //             //         .getDataList(
//               //             //             controller.selectedCategory.value.name)
//               //             //         ?.elements[index]
//               //             //         .step
//               //             //         .toString() ??
//               //             //     'Null'),
//               //           ));
//               //         },
//               //       )),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
