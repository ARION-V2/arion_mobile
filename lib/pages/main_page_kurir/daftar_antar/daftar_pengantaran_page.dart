part of '../../pages.dart';

class DaftarPengantaranPage extends StatefulWidget {
  const DaftarPengantaranPage({Key? key}) : super(key: key);

  @override
  State<DaftarPengantaranPage> createState() => _DaftarPengantaranPageState();
}

class _DaftarPengantaranPageState extends State<DaftarPengantaranPage> {
  final deliveryController = Get.find<DeliveryController>();
  @override
  void initState() {
    super.initState();
    deliveryController.getMappingAll();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      onRefresh: () async {
        await deliveryController.getMappingAll();
      },
      titleAppBar: Obx(() => Text(
          'Daftar Pengantaran (${deliveryController.mappingDeliveryModel.length})')),
      actionsAppBar: const [
        Padding(
          padding: EdgeInsets.only(right: defaultMargin),
          child: Icon(
            Icons.search,
            color: whiteColor,
          ),
        )
      ],
      backgroundColorAppBar: mainColor,
      body: deliveryController.obxCustom((state) {
        return Obx(
          () => (deliveryController.loadingMapping.value)
              ? Center(
                  child: loading(4),
                )
              : ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    (deliveryController.mappingDeliveryModel.isNotEmpty)
                        ? Column(
                            children: List.generate(
                              deliveryController.mappingDeliveryModel.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  if (deliveryController
                                          .mappingDeliveryModel[index]
                                          .fromDelivery !=
                                      null) {
                                    Get.to(DetailPengantaranPage(
                                      delivery: deliveryController
                                          .mappingDeliveryModel[index],
                                    ));
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(bottom: 15),
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: (deliveryController
                                                  .mappingDeliveryModel[index]
                                                  .fromGudang !=
                                              null)
                                          ? accentColor1
                                          : whiteColor,
                                      boxShadow: [
                                        customShadow(),
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (deliveryController
                                              .mappingDeliveryModel[index]
                                              .fromDelivery !=
                                          null)
                                        Text(
                                          "No Resi : ${deliveryController.mappingDeliveryModel[index].fromDelivery?.noResi}",
                                          style: blackTextFontTitleBold,
                                        ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 80,
                                            child: Text("Posisi"),
                                          ),
                                          (deliveryController
                                                      .mappingDeliveryModel[
                                                          index]
                                                      .fromDelivery
                                                      ?.partner
                                                      ?.marketName !=
                                                  null)
                                              ? Text(
                                                  ": ${deliveryController.mappingDeliveryModel[index].fromDelivery?.partner?.marketName}")
                                              : Text(
                                                  ": ${deliveryController.mappingDeliveryModel[index].fromGudang?.namaGudang}"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 80,
                                            child: Text("Selanjutnya"),
                                          ),
                                          (deliveryController
                                                      .mappingDeliveryModel[
                                                          index]
                                                      .nextDelivery
                                                      ?.partner
                                                      ?.marketName !=
                                                  null)
                                              ? Text(
                                                  ": ${deliveryController.mappingDeliveryModel[index].nextDelivery?.partner?.marketName}")
                                              : Text(
                                                  ": ${deliveryController.mappingDeliveryModel[index].toGudang?.namaGudang}"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 80,
                                            child: Text("Jarak"),
                                          ),
                                          Text(
                                            ': ${(deliveryController.mappingDeliveryModel[index].distance! / 1000).toStringAsFixed(2)} km',
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const DataNotFoundWidget(),
                    // (deliveryController.mappingDeliveryModel.isNotEmpty)
                    //     ? Column(
                    //         children: List.generate(
                    //           deliveryController.waitingDeliveriesModel.length,
                    //           (index) => ItemPengantaranWidget(
                    //             delivey: deliveryController
                    //                 .mappingDeliveryModel[index],
                    //             onTap: () {
                    //               // Get.to(
                    //               //   () => DetailPengantaranPage(
                    //               //       delivery: deliveryController
                    //               //           .waitingDeliveriesModel[index]),
                    //               // );
                    //             },
                    //           ),
                    //         ),
                    //       )
                    //     : const DataNotFoundWidget(),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
        );
      }, onRefreshData: () {}),
      floatingButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => (deliveryController.loadingMapping.value)
                ? loading(3)
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: mainColor),
                    onPressed: () {
                      Get.to(
                        () => const MapsLocationView(),
                        binding: MapsLocationBinding(),
                        arguments: MapLocationArgument(
                          deliveries: deliveryController.mappingDeliveryModel,
                          // deliveryPlusDirection:
                          //     deliveryController.waitingDeliveriesPlusDirection,
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_pin,
                          color: whiteColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Lihat Semua Lokasi",
                          style: whiteTextFontBold,
                        )
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
