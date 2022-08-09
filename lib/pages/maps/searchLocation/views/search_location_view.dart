import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_place/google_place.dart';

import '../../../../shared/shared.dart';
import '../../../../widgets/widgets.dart';
import '../controllers/search_location_controller.dart';

class SearchLocationView extends GetView<SearchLocationController> {
  const SearchLocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
              const  SizedBox(
                  height: 120,
                ),
                Obx(
                  () => (controller.predictions.isNotEmpty)
                      ? Column(
                          children: List.generate(controller.predictions.length,
                              (index) {
                            return AddressItemWidget(
                                prediction: controller.predictions[index],
                                isEnd:
                                    index == controller.predictions.length - 1);
                          }),
                        )
                      : (controller.searchText.value.trim()!="")? const DataNotFoundWidget():const DataSearchWidget(),
                ),
              ],
            ),
            Container(
              color: whiteColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                const  SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding:const EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: HeaderAddAddressPage(),
                  ),
                const  SizedBox(
                    height: 24,
                  ),
                const  Divider(
                    thickness: 5,
                    color: Color(0xFFF7F7F7),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressItemWidget extends StatelessWidget {
  AddressItemWidget({
    Key? key,
    required this.prediction,
    this.isEnd = false,
  }) : super(key: key);

  final AutocompletePrediction prediction;
  final bool isEnd;

  final controller = Get.find<SearchLocationController>();

  @override
  Widget build(BuildContext context) {
    String title = prediction.description!.split(',').first;
    String fullAddess = prediction.description ?? "";

    return Column(
      children: [
        MaterialButton(
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          onPressed: () {
            Get.back(
              result: {
                'prediction': prediction,
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_pin, size: 20,),
              const  Icon(Icons.location_pin,),
              const  SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: blackTextFontTitle.copyWith(fontSize: 16),
                      ),
                   const   SizedBox(
                        height: 8,
                      ),
                      Text(
                        fullAddess,
                        style: blackTextFont,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!isEnd)
         const Padding(
            padding: const EdgeInsets.only(left: 64),
            child: Divider(
              height: 10,
              thickness: 2,
              color: greyColor2,
            ),
          ),
      ],
    );
  }
}

class HeaderAddAddressPage extends StatelessWidget {
  HeaderAddAddressPage({
    Key? key,
  }) : super(key: key);
  final controller = Get.find<SearchLocationController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child:const Icon(
            Icons.arrow_back_rounded,
            size: 30,
          ),
        ),
       const SizedBox(
          width: 25,
        ),
        Expanded(
          child: SizedBox(
            height: 44,
            child: TextFormField(
              controller: controller.searchController,
              textAlignVertical: TextAlignVertical.center,
              style: blackTextFontTitle,
              onChanged: (value) {
                controller.searchAddress();
                controller.searchText.value =value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide:const BorderSide(
                      color: mainColor,
                    )),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide:const BorderSide(
                    color: mainColor,
                  ),
                ),
                isDense: true,
                hintText: "Cari alamat",
                hintStyle: greyTextFontTitle,
                contentPadding:
                  const  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  size: 30,
                  color: blackColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
