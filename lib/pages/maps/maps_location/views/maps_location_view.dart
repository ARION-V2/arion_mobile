import 'package:arion/extensions/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../shared/shared.dart';
import '../../../../../widgets/widgets.dart';
import '../controllers/maps_location_controller.dart';

class MapsLocationView extends GetView<MapsLocationController> {
  const MapsLocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      titleAppBar:const  Text("Lokasi Pengiriman"),
      body: controller.obxCustom(
         (state) {
          return SizedBox(
                height: Get.height,
                width: Get.width,
                child: GetBuilder<MapsLocationController>(
                  init: MapsLocationController(),
                  builder: (controller) => Stack(
                    children: [
                      GoogleMap(
                        mapType: MapType.hybrid,
                        initialCameraPosition:
                            controller.cameraPositionCustom(controller.initialPosition),
                        onMapCreated: controller.onMapCreated,
                        markers: Set<Marker>.from(controller.markers.value),
                        zoomControlsEnabled: true,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        polylines:  Set<Polyline>.from(controller.polinines.value),
                        
                      ),
                      
                    ],
                  ),
                ),
              );
        }, onRefreshData: () {  }
      ),
    );
  }
}
