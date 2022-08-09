part of '../../pages.dart';

class DetailPengantaranPage extends StatefulWidget {
  const DetailPengantaranPage({Key? key, required this.delivery})
      : super(key: key);
  final MappingDelivery delivery;
  @override
  State<DetailPengantaranPage> createState() => _DetailPengantaranPageState();
}

class _DetailPengantaranPageState extends State<DetailPengantaranPage> {
  late GoogleMapController controllerMap;
  var customMarkers = List<Marker>.empty().obs;

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(-6.400456, 108.280855),
    zoom: 16,
  );
  late BitmapDescriptor pinLocation;
  MappingDelivery? currentDelivery;
  @override
  void initState() {
    super.initState();
    currentDelivery = widget.delivery;
    kGooglePlex = CameraPosition(
      target: LatLng(double.parse(widget.delivery.fromDelivery!.partner!.latitude!),
          double.parse(widget.delivery.fromDelivery!.partner!.longitude!)),
      zoom: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      titleAppBar: const Text("Detail Pengantaran"),
      backgroundColorAppBar: mainColor,
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            children: [
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  ItemPengantaranWidget(delivey: widget.delivery.fromDelivery),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.to(
                  //       () => const PhotoViewCustom(
                  //         [
                  //           'https://asset.kompas.com/crops/tEaQm4OcnYi0s94vimJ6U5nZbok=/0x0:800x533/750x500/data/photo/2019/04/30/3838958269.jpg'
                  //         ],
                  //       ),
                  //     );
                  //   },
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       const Icon(
                  //         Icons.image,
                  //         color: mainColor,
                  //       ),
                  //       const SizedBox(
                  //         width: 10,
                  //       ),
                  //       Text(
                  //         "Lihat foto barang",
                  //         style: redTextFont,
                  //       )
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pengirim",
                        style: blackTextFontTitleBold,
                      ),
                      CardCourierWidget(
                        courier: widget.delivery.fromDelivery!.courier!,
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Produk",
                          style: blackTextFontTitleBold,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 235,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                widget.delivery.fromDelivery!.products!.length,
                                (index) => Container(
                                  width: 150,
                                  padding: const EdgeInsets.only(right: 10),
                                  child: ProductCardDeliveryWidget(
                                      productDelivery:
                                          widget.delivery.fromDelivery!.products![index]),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                    future: setCustomMapPin(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: const Color(0xFFE6E6E6), width: 2),
                            ),
                          ),
                        );
                      }
                      if (snapshot.error != null) {
                        return Center(
                          child: Text(
                            "Mengakses Maps Gagal\n\nPastikan anda telah mengaktifkan GPS dan menyetujui pengaksesan lokasi",
                            style: blackTextFont,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      return mapsWidget();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButtonWidget(
                    title: "Petuntuk Arah",
                    onTap: () {
                      redirectToMaps();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: ButtonBottomDetailItemWidget(
        title1: "Pengiriman Telah Diterima",
        onTap1: () {
          Get.to(
            () =>  AntarPaketSelesaiPage(delivery: widget.delivery.fromDelivery!,),
          );
        },
      ),
    );
  }

  void redirectToMaps() async {
    final availableMaps = await mapLauncher.MapLauncher.installedMaps;
    await availableMaps.first.showDirections(
      destination: mapLauncher.Coords(
          kGooglePlex.target.latitude, kGooglePlex.target.longitude),
      destinationTitle: "Penerima paket",
      directionsMode: mapLauncher.DirectionsMode.driving,
    );
  }

  Marker buildMarker(LatLng position) {
    return Marker(
      markerId: const MarkerId(
        "sourcePin",
      ),
      position: position,
      // icon: pinLocation,
    );
  }

  setCustomMapPin() async {
    customMarkers.add(
      buildMarker(kGooglePlex.target),
    );
    return true;
  }

  Widget mapsWidget() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      height: 160,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: greyColor2)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GoogleMap(
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          markers: customMarkers.toSet(),
          initialCameraPosition: kGooglePlex,
          onMapCreated: (GoogleMapController controllerMap) {
            controllerMap = controllerMap;
          },
        ),
      ),
    );
  }
}


// class ShowMapsWidget extends StatelessWidget {
//   const ShowMapsWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: BoxConstraints(maxWidth: 500),
//       height: 160,
//       width: Get.width,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: greyColor2)),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: GoogleMap(
//           mapType: MapType.normal,
//           zoomControlsEnabled: false,
//           markers: controller.customMarkers.toSet(),
//           initialCameraPosition: controller.kGooglePlex,
//           onMapCreated: (GoogleMapController controllerMap) {
//             controller.controllerMap = controllerMap;
//           },
//         ),
//       ),
//     );
//   }
// }
