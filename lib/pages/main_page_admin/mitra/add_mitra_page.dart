part of '../../pages.dart';

class AddMitraPage extends StatefulWidget {
  const AddMitraPage({
    Key? key,
    this.partner,
  }) : super(key: key);
  final Partner? partner;

  @override
  State<AddMitraPage> createState() => _AddMitraPageState();
}

class _AddMitraPageState extends State<AddMitraPage> {
  var partnerController = Get.find<PartnerController>();
  var myCoordinate = const LatLng(-6.175441, 106.827008).obs;
  var selectedCoordinate = Rxn<LatLng>();
  var resultSelectedInMaps = Rxn<ResultLocationInMaps>();

  TextEditingController namaPemilikController = TextEditingController();
  TextEditingController namaTokoController = TextEditingController();
  TextEditingController noHpController = TextEditingController();

  TextEditingController fullAddressController = TextEditingController();
  TextEditingController koordinatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.partner != null) {
      namaPemilikController.text = widget.partner!.fullName!;
      namaTokoController.text = widget.partner!.marketName!;
      noHpController.text = widget.partner!.noHp!;
      fullAddressController.text = widget.partner!.address!;
      koordinatController.text =
          "${widget.partner!.latitude!}, ${widget.partner!.longitude!}";

      myCoordinate.value = LatLng(double.parse(widget.partner!.latitude!),
          double.parse(widget.partner!.longitude!));

      resultSelectedInMaps.value = ResultLocationInMaps(
        fullAddress: widget.partner!.address!,
        posCode: '',
        coordinate: LatLng(
          double.parse(widget.partner!.latitude!),
          double.parse(widget.partner!.longitude!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      titleAppBar: const Text("Tambah Mitra"),
      backgroundColorAppBar: mainColor,
      actionsAppBar: [
        if (widget.partner != null)
          TextButton(
            onPressed: () async {
              partnerController.deletePartner(widget.partner!);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                "Hapus",
                style: whiteTextFontBold,
              ),
            ),
          )
      ],
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          const SizedBox(
            height: 20,
          ),
          FieldCustomWidget(
            title: "Nama Lengkap Pemilik",
            hint: "Masukan nama pemilik",
            controller: namaPemilikController,
          ),
          const SizedBox(
            height: 15,
          ),
          FieldCustomWidget(
            title: "Nama Toko",
            hint: "Masukan nama toko",
            controller: namaTokoController,
          ),
          const SizedBox(
            height: 15,
          ),
          FieldCustomWidget(
            title: "Nomor HP",
            hint: "Masukan nomor HP",
            controller: noHpController,
            typeKeyboard: TextInputType.phone,
          ),
          const SizedBox(
            height: 15,
          ),
          FutureBuilder(
              future: determinePosition(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: 50,
                    child: Shimmer.fromColors(
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
                return CustomButtonWidget(
                    title: "Cari Lokasi", onTap: goToMapsPage);
              }),
          const SizedBox(
            height: 15,
          ),
          if (resultSelectedInMaps.value != null)
            FieldCustomWidget(
              title: "Alamat Lengkap",
              hint: "Masukan alamat lengkap",
              controller: fullAddressController,
              maxLine: 5,
              height: 100,
            ),
          if (resultSelectedInMaps.value != null)
            const SizedBox(
              height: 15,
            ),
          if (resultSelectedInMaps.value != null)
            FieldCustomWidget(
              title: "Koordinat Lokasi",
              hint: "Masukan Koordinat Likasi",
              controller: koordinatController,
              enabled: false,
            ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
      bottomNavigationBar: ButtonBottomDetailItemWidget(
        title1: "Simpan",
        onTap1: () async {
          if (!(namaPemilikController.text.trim() != '' &&
              namaTokoController.text.trim() != '' &&
              fullAddressController.text.trim() != '' &&
              noHpController.text.trim() != '')) {
            snackbarCustom(
                typeSnackbar: TypeSnackbar.error,
                message: "Harap mengisi seluruh data terlebih dahulu");
          } else {
            Partner partnerRequest;
            if (widget.partner == null) {
              partnerRequest = Partner(
                fullName: namaPemilikController.text,
                marketName: namaTokoController.text,
                address: fullAddressController.text,
                latitude:
                    resultSelectedInMaps.value?.coordinate.latitude.toString(),
                longitude:
                    resultSelectedInMaps.value?.coordinate.longitude.toString(),
                noHp: noHpController.text,
              );
            } else {
              partnerRequest = widget.partner!.copyWith(
                fullName: namaPemilikController.text,
                marketName: namaTokoController.text,
                address: fullAddressController.text,
                latitude:
                    resultSelectedInMaps.value?.coordinate.latitude.toString(),
                longitude:
                    resultSelectedInMaps.value?.coordinate.longitude.toString(),
                noHp: noHpController.text,
              );
            }
            partnerController.addPartner(partnerRequest);
          }
        },
      ),
    );
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position myCoordinateResult = await Geolocator.getCurrentPosition();

    myCoordinate.value = LatLng(myCoordinateResult.latitude,
        myCoordinateResult.longitude); // await setCustomMapPin();

    return myCoordinateResult;
  }

  void goToMapsPage() async {
    var result = await Get.to(
      () => const SelectLocationView(),
      binding: SelectLocationBinding(),
      arguments: {
        "initialLocation": myCoordinate.value,
      },
    );

    if (result != null) {
      resultSelectedInMaps.value = result;
      myCoordinate.value = resultSelectedInMaps.value!.coordinate;
      koordinatController.text =
          "${resultSelectedInMaps.value!.coordinate.latitude}, ${resultSelectedInMaps.value!.coordinate.longitude}";
      fullAddressController.text = resultSelectedInMaps.value!.fullAddress;
      setState(() {});
    }
  }
}

class ResultLocationInMaps {
  final String fullAddress;
  final String posCode;
  final LatLng coordinate;

  ResultLocationInMaps({
    required this.fullAddress,
    required this.posCode,
    required this.coordinate,
  });
}
