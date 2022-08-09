part of '../../pages.dart';

class DashboardPageAdmin extends StatefulWidget {
  const DashboardPageAdmin({Key? key}) : super(key: key);

  @override
  State<DashboardPageAdmin> createState() => _DashboardPageAdminState();
}

class _DashboardPageAdminState extends State<DashboardPageAdmin> {
  final userController = Get.put(UserController());
  final locationController =Get.put(LocationController());
  final courierController = Get.put(CourierController());
  final partnerController = Get.put(PartnerController());
  final productController = Get.put(ProductController());
  final deliveryController = Get.put(DeliveryController());

  @override
  void initState() {
    super.initState();
    locationController.searchMyLocation();
    userController.getUser();
    partnerController.getAllPartner();
    courierController.getAll();
    productController.getAll();
    deliveryController.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      statusBarColor: mainColor,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(defaultMargin),
            height: 90,
            width: Get.width,
            decoration: const BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "ARION EXPRESS",
                  style: whiteTextFontBigBold.copyWith(fontSize: 25),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: MenuWidget(
                        title: "Kurir",
                        icon: Icons.groups,
                        onTap: () {
                          Get.to(
                            () => ListKulirPage(),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: defaultMargin,
                    ),
                    Expanded(
                      child: MenuWidget(
                        title: "Pengiriman",
                        icon: Icons.delivery_dining,
                        onTap: () {
                          Get.to(() => ListDeliveryPage());
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MenuWidget(
                        title: "Mitra",
                        icon: Icons.store,
                        onTap: () {
                          Get.to(() => const ListMitraPage());
                        },
                      ),
                    ),
                    const SizedBox(
                      width: defaultMargin,
                    ),
                    Expanded(
                      child: MenuWidget(
                        title: "Laporan",
                        icon: Icons.description,
                        onTap: () {
                          //  Get.to(()=> DaftarRiwayatPage());
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MenuWidget(
                        title: "Produk",
                        icon: Icons.inventory_2_outlined,
                        onTap: () {
                          Get.to(() => ListProductPage());
                        },
                      ),
                    ),
                    const SizedBox(
                      width: defaultMargin,
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
      bottomNavigationBar: ButtonBottomDetailItemWidget(
        title1: 'Logout',
        onTap1: () {
          Get.dialog(
            ShowDialongComfirm(
              textMessage: "Apakah anda yakin akan keluar dari akun ini?",
              comfirmOkColor: redColor,
              onConfirmOk: () {
                UserController().logout();
              },
            ),
          );
        },
      ),
    );
  }
}
