part of '../../pages.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
    final locationController = Get.put(LocationController());

  final deliveryController = Get.put(DeliveryController());
  @override
  void initState() {
    super.initState();
    locationController.searchMyLocation();
    deliveryController.getDoneDeliveries();
    // deliveryController.getWaitingDelivery();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      statusBarColor: mainColor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(defaultMargin),
            height: 150,
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
                  height: 50,
                ),
                Text(
                  "ARION EXPRESS",
                  style: whiteTextFontBigBold.copyWith(fontSize: 25),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: MenuWidget(
                        title: "Daftar Antar",
                        icon: Icons.list,
                        onTap: () {
                          Get.to(() => DaftarPengantaranPage());
                        },
                      ),
                    ),
                    const SizedBox(
                      width: defaultMargin,
                    ),
                    Expanded(
                      child: MenuWidget(
                        title: "Riwayat POD",
                        icon: Icons.history,
                        onTap: () {
                          Get.to(() => DaftarRiwayatPage());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
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

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.title,
  }) : super(key: key);
  final Function() onTap;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: Get.width / 2 - (3 * defaultMargin),
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 3),
                  color: mainColor.withOpacity(0.2),
                  blurRadius: 10)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: mainColor,
              size: 60,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: redTextFontBigBold,
            )
          ],
        ),
      ),
    );
  }
}
