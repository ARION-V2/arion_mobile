part of '../../pages.dart';

class DetailDeliveryPage extends StatefulWidget {
  const DetailDeliveryPage({
    Key? key,
    required this.idDelivery,
  }) : super(key: key);
  final int idDelivery;

  @override
  State<DetailDeliveryPage> createState() => _DetailDeliveryPageState();
}

class _DetailDeliveryPageState extends State<DetailDeliveryPage> {
  final deliveryController = Get.find<DeliveryController>();
  var delivery = Rxn<Delivery>();
  @override
  void initState() {
    super.initState();
    delivery.value = deliveryController.deliveries
        .firstWhere((element) => element.id == widget.idDelivery);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GeneralPage(
        backgroundColorAppBar: mainColor,
        titleAppBar: const Text("Detail Pengiriman"),
        actionsAppBar: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                margin: const EdgeInsets.only(right: defaultMargin),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: delivery.value!.colorStatus,
                ),
                child: Obx(
                  () => Text(
                    "${delivery.value!.status}",
                    style: whiteTextFont.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
        body: ListView(
          // shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "No. Resi : ${delivery.value!.noResi}",
              style: blackTextFontTitleBold,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "${delivery.value!.partner!.marketName}",
              style: blackTextFontTitleBold,
            ),
            Text(
              "${delivery.value!.partner!.fullName}",
              style: blackTextFont,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "${delivery.value!.partner!.address}",
              style: blackTextFont,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              "${delivery.value!.partner!.noHp}",
              style: blackTextFont,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 242, 255, 160)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Paket dalam antrian pada:"),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    DateTime.parse(delivery.value!.createdAt!)
                        .toUtc()
                        .toLocal()
                        .dateAndTime,
                    style: blackTextFontTitleBold,
                  ),
                ],
              ),
            ),
            if (delivery.value!.dateDelivery != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 115, 232, 248)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Paket dalam pengiriman pada:"),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      DateTime.parse(delivery.value!.dateDelivery!)
                          .toUtc()
                          .toLocal()
                          .dateAndTime,
                      style: blackTextFontTitleBold,
                    ),
                  ],
                ),
              ),
            if (delivery.value!.dateReceived != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 150, 255, 142)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Paket telah diterima pada:"),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      DateTime.parse(delivery.value!.dateReceived!)
                          .toUtc()
                          .toLocal()
                          .dateAndTime,
                      style: blackTextFontTitleBold,
                    ),
                  ],
                ),
              ),
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
                  courier: delivery.value!.courier!,
                  onTap: () {},
                ),
              ],
            ),
            Column(
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
                        delivery.value!.products!.length,
                        (index) => Container(
                          width: 150,
                          padding: const EdgeInsets.only(right: 10),
                          child: ProductCardDeliveryWidget(
                              productDelivery:
                                  delivery.value!.products![index]),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Foto Penerimaan",
              style: blackTextFontTitleBold,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      Get.to(
                        () =>  PhotoViewCustom(
                          [
                            delivery.value!.photoReceived!
                          ],
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: Get.width / 2 - (defaultMargin),
                            width: Get.width,
                            child: CacheImageCustom(
                                url: delivery.value!.photoReceived,
                                imageBuilder: (_, imageProv) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: greyColor2,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        customShadow(),
                                      ],
                                      image: DecorationImage(
                                        image: imageProv,
                                      ),
                                    ),
                                  );
                                })),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Keterangan Penerima:",
              style: blackTextFontBold,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "-",
                style: greyTextFontTitle,
              ),
            ),
            Text(
              "Catatan:",
              style: blackTextFontBold,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "-",
                style: greyTextFontTitle,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
        bottomNavigationBar: Obx(() {
          if (delivery.value!.status == "Pending") {
            return ButtonBottomDetailItemWidget(
              title1: "Kirimkan Sekarang",
              onTap1: () async {
                var result = await deliveryController.addDelivery(
                  delivery: delivery.value!.copyWith(status: "On Progress"),
                );
                if (result != null) {
                  delivery.value = result;
                }
              },
            );
          } else if (delivery.value!.status == "On Progress") {
            return ButtonBottomDetailItemWidget(
              title1: "Telah Diterima",
              onTap1: () async {
                var result = await deliveryController.addDelivery(
                  delivery: delivery.value!.copyWith(
                    status: "Berhasil",
                    
                  ),
                );
                if (result != null) {
                  delivery.value = result;
                }
              },
            );
          } else {
            return const SizedBox();
          }
        }),
      );
    });
  }
}
