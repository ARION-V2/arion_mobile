part of '../../pages.dart';

class ListKulirPage extends StatelessWidget {
  ListKulirPage({Key? key}) : super(key: key);
  final courierController = Get.find<CourierController>();
  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      titleAppBar: const Text("Kurir"),
      backgroundColorAppBar: mainColor,
      body: courierController.obxCustom((state) {
        return ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => Column(
                children:
                    List.generate(courierController.couriers.length, (index) {
                  User courier = courierController.couriers[index];
                  return ListTile(
                    onTap: () {
                      Get.to(
                        () => AddKurirPage(
                          courier: courier,
                        ),
                      );
                    },
                    leading: CircleAvatarCustom(
                      url: courier.photo,
                      diameter: 50,
                      isPerson: true,
                    ),
                    title: Text(
                      "${courier.name}",
                      style: blackTextFontTitle,
                    ),
                    subtitle: Text(
                      "${courier.noHp}",
                      style: blackTextFont,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      }, onRefreshData: () {
        courierController.getAll();
      }),
      floatingButton: GestureDetector(
        onTap: () async {
          await Get.to(
            () => const AddKurirPage(),
          );
        },
        child: const SizedBox(
          height: 60,
          width: 60,
          child: CircleAvatar(
            backgroundColor: mainColor,
            child: Icon(
              Icons.add,
              color: whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
