part of '../../pages.dart';

class AntarPaketSelesaiPage extends StatefulWidget {
  const AntarPaketSelesaiPage({
    Key? key,
    required this.delivery,
  }) : super(key: key);
  final Delivery delivery;

  @override
  State<AntarPaketSelesaiPage> createState() => _AntarPaketSelesaiPageState();
}

class _AntarPaketSelesaiPageState extends State<AntarPaketSelesaiPage> {
  String? selectedPenerima;
  TextEditingController namaPenerimaController = TextEditingController();
  TextEditingController catatanController = TextEditingController();
  File? selectedPhoto, signatureFile;

  var deliveryController = Get.find<DeliveryController>();

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      titleAppBar: const Text("Antar Paket"),
      backgroundColorAppBar: mainColor,
      actionsAppBar: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultMargin, vertical: 10),
          child: Text(
            'Selesai',
            style: whiteTextFontTitle,
          ),
        )
      ],
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          const SizedBox(
            height: 20,
          ),
          // ItemPengantaranWidget(),
          Row(
            children: [
              const Icon(
                Icons.done_rounded,
                color: Colors.green,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Diterima',
                style: blackTextFontBold,
              )
            ],
          ),
          Divider(
            color: greyColor,
          ),
          DropDownWidget(
            title: 'Status Penerima',
            list: const [
              '(YBS) Yang Bersangkutan',
              '(KRY) Karyawan',
              '(KEL) Keluarga',
            ],
            result: (value) {
              setState(() {
                selectedPenerima = value;
              });
            },
            hint: 'Pilih Status Penerima',
            value: selectedPenerima,
          ),
          const SizedBox(
            height: 20,
          ),
          FieldCustomWidget(
            title: "Nama Penerima",
            hint: 'Masukan nama penerima',
            controller: namaPenerimaController,
          ),
          const SizedBox(
            height: 20,
          ),
          FieldCustomWidget(
            title: "Catatan",
            hint: 'Masukan catatan',
            controller: catatanController,
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              // Expanded(
              //     child: GestureDetector(
              //   onTap: () async {
              //     var result = await Get.to(
              //       () => const TandaTanganPage(),
              //     );
              //     if (result != null && result is File) {
              //       setState(() {
              //         signatureFile = result;
              //       });
              //     }
              //   },
              //   child: Container(
              //     height: Get.width / 2 - (3 * defaultMargin),
              //     width: Get.width,
              //     decoration: BoxDecoration(
              //         color: greyColor2,
              //         borderRadius: BorderRadius.circular(10),
              //         boxShadow: [
              //           customShadow(),
              //         ],
              //         image: (signatureFile != null)
              //             ? DecorationImage(
              //                 image: FileImage(
              //                   signatureFile!,
              //                 ),
              //                 fit: BoxFit.cover)
              //             : null),
              //     child: (signatureFile != null)
              //         ? null
              //         : Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: const [
              //               Icon(
              //                 Icons.edit,
              //                 size: 40,
              //                 color: greyColor,
              //               ),
              //               SizedBox(
              //                 height: 10,
              //               ),
              //               Text("Tambah Tandatangan")
              //             ],
              //           ),
              //   ),
              // )),
              // const SizedBox(
              //   width: defaultMargin,
              // ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    var result = await getSingleImage(context);
                    if (result != null) {
                      setState(() {
                        selectedPhoto = result;
                      });
                    }
                  },
                  child: Container(
                    height: Get.width / 2,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: greyColor2,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          customShadow(),
                        ],
                        image: (selectedPhoto != null)
                            ? DecorationImage(
                                image: FileImage(
                                  selectedPhoto!,
                                ),
                                fit: BoxFit.cover)
                            : null),
                    child: (selectedPhoto == null)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.photo,
                                size: 40,
                                color: greyColor,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Tambah Foto")
                            ],
                          )
                        : null,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
      bottomNavigationBar: ButtonBottomDetailItemWidget(
        title1: 'Selesai',
        onTap1: () async {
          if (selectedPenerima == null) {
            snackbarCustom(
                typeSnackbar: TypeSnackbar.info,
                message: "Harap memilih status penerima terlebih dahulu");
          } else if (namaPenerimaController.text.trim() == "") {
            snackbarCustom(
                typeSnackbar: TypeSnackbar.info,
                message: "Harap untuk memulis nama penerima terlebih dahulu");
          } else if (selectedPhoto == null) {
            snackbarCustom(
                typeSnackbar: TypeSnackbar.info,
                message:
                    "Harap untuk menambahkan bukti foto penerimaan terlebih dahulu");
          } else {
            showLoading();
            var result = await deliveryController.addDelivery(
              delivery: widget.delivery.copyWith(
                status: 'Berhasil',
                statusReceived: selectedPenerima,
              ),
              file: selectedPhoto,
            );
            EasyLoading.dismiss();
            if (result != null) {
              Get.offAll(const DashboardPage());
            }
          }
        },
      ),
    );
  }
}
