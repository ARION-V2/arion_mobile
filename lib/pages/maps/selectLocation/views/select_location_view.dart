import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../shared/shared.dart';
import '../../../../widgets/widgets.dart';
import '../controllers/select_location_controller.dart';

class SelectLocationView extends GetView<SelectLocationController> {
  const SelectLocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      body: SafeArea(
        child: FutureBuilder(
          future: controller.setCustomMapPin(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: Get.height,
                width: Get.width,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: mainColor,
                  ),
                ),
              );
            }
            return GetBuilder<SelectLocationController>(
              builder: (controller) {
                return Stack(
                  children: [
                    SizedBox(
                      height: Get.height * 0.75,
                      child: Stack(
                        children: [
                          GoogleMap(
                            mapType: MapType.normal,
                            zoomControlsEnabled: false,
                            initialCameraPosition: controller.kGooglePlex,
                            // markers: controller.customMarkers.toSet(),
                            onMapCreated: (GoogleMapController controllerMap) {
                              controller.controllerMap = controllerMap;
                            },
                            onCameraMove: (CameraPosition cameraPosition) {
                              controller.kGooglePlex = cameraPosition;
                              if (!controller.onMoveCamera.value) {
                                controller.onMoveCamera.value = true;
                              }
                              // controller.searchAddress();
                              // controller.update();
                            },
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.location_pin,
                                  color: mainColor,
                                  size: 50,
                                ),
                                SizedBox(
                                  height: 60,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.goToSearch,
                      child: Container(
                        width: Get.width,
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: defaultMargin),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 13),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: whiteColor),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search_rounded,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                controller.searchText.value,
                                style: greyTextFontTitle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 215,
                            width: Get.width,
                            margin: const EdgeInsets.only(top: 30),
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 0),
                                      blurRadius: 6,
                                      color: blackColor.withOpacity(0.2)),
                                ]),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.store,
                                      size: 40,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: 70,
                                        child: Obx(
                                          () => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                           Text(
                                                controller
                                                    .streetAddressName.value,
                                                style: blackTextFontTitleBold
                                                    .copyWith(fontSize: 16),
                                              ),
                                              // : CustomShimmerWidget(
                                              //     child: Container(
                                              //       width: 200,
                                              //       height: 15,
                                              //       color: whiteColor,
                                              //     ),
                                              //   ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                               Expanded(
                                                child: AutoSizeText(
                                                  controller
                                                      .fullAddressName.value,
                                                  style: blackTextFont,
                                                  minFontSize: 8,
                                                  maxFontSize: 12,
                                                  // overflow: TextOverflow.ellipsis,
                                                ),
                                              )
                                              // : CustomShimmerWidget(
                                              //     child: Container(
                                              //       width: Get.width * 0.75,
                                              //       height: 40,
                                              //       color: whiteColor,
                                              //     ),
                                              //   ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Obx(
                                  () => CustomButtonWidget(
                                    onTap: controller.save,
                                    title: (controller.onMoveCamera.value)
                                        ? "Sinkronkan"
                                        : "Simpan",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
