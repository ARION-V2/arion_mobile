part of '../../pages.dart';

class DaftarPengantaranPage extends StatefulWidget {
  const DaftarPengantaranPage({Key? key}) : super(key: key);

  @override
  State<DaftarPengantaranPage> createState() => _DaftarPengantaranPageState();
}

class _DaftarPengantaranPageState extends State<DaftarPengantaranPage> {
  final deliveryController = Get.find<DeliveryController>();
  TspAnnaling? matrixDistance;
  @override
  void initState() {
    super.initState();
    deliveryController.getWaitingDelivery();
    matrixDistance = deliveryController.resultMatrix.value;
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      onRefresh: () async {
        await deliveryController.getWaitingDelivery();
      },
      titleAppBar: Obx(() => Text(
          'Daftar Pengantaran (${deliveryController.waitingDeliveriesModel.length})')),
      actionsAppBar: [
        Padding(
          padding: const EdgeInsets.only(right: defaultMargin),
          child: Center(
            child: GestureDetector(
              onTap: () {
                Get.to(() =>const MatrixJarakPage());
              },
              child: Text(
                "Matrix",
                style: whiteTextFontBold,
              ),
            ),
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
                    Text(
                      "Total Jarak = ${deliveryController.resultMatrix.value?.jarak!.toInt()} m atau ${(deliveryController.resultMatrix.value!.jarak!/1000).toStringAsFixed(2)} km",
                      style: blackTextFontBold,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    (deliveryController.resultMapping.isNotEmpty)
                        ? Column(
                            children: List.generate(
                              deliveryController.resultMapping.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  if (deliveryController
                                          .resultMapping[index].fromDelivery !=
                                      null) {
                                    Get.to(DetailPengantaranPage(
                                      delivery: deliveryController
                                          .resultMapping[index],
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
                                                  .resultMapping[index]
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
                                              .resultMapping[index]
                                              .fromDelivery !=
                                          null)
                                        Text(
                                          "No Resi : ${deliveryController.resultMapping[index].fromDelivery?.noResi}",
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
                                                      .resultMapping[index]
                                                      .fromDelivery
                                                      ?.partner
                                                      ?.marketName !=
                                                  null)
                                              ? Text(
                                                  ": ${deliveryController.resultMapping[index].fromDelivery?.partner?.marketName}")
                                              : Text(
                                                  ": ${deliveryController.resultMapping[index].fromGudang?.namaGudang}"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 80,
                                            child: Text("Selanjutnya"),
                                          ),
                                          (deliveryController
                                                      .resultMapping[index]
                                                      .nextDelivery
                                                      ?.partner
                                                      ?.marketName !=
                                                  null)
                                              ? Text(
                                                  ": ${deliveryController.resultMapping[index].nextDelivery?.partner?.marketName}")
                                              : Text(
                                                  ": ${deliveryController.resultMapping[index].toGudang?.namaGudang}"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 80,
                                            child: Text("Jarak"),
                                          ),
                                          Text(
                                            ' : ${(deliveryController.resultMapping[index].distance! / 1000).toStringAsFixed(2)} km',
                                            // ': ${(deliveryController.resultMapping[index].distance!)}',
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
                    // (deliveryController.resultMapping.isNotEmpty)
                    //     ? Column(
                    //         children: List.generate(
                    //           deliveryController.waitingDeliveriesModel.length,
                    //           (index) => ItemPengantaranWidget(
                    //             delivey: deliveryController
                    //                 .resultMapping[index],
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
                          deliveries: deliveryController.resultMapping,
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
