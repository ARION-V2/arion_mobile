part of '../../pages.dart';

class ListDeliveryPage extends StatelessWidget {
  ListDeliveryPage({Key? key}) : super(key: key);
  final deliveryController = Get.find<DeliveryController>();

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      titleAppBar: const Text("Daftar Pengiriman"),
      backgroundColorAppBar: mainColor,
      body: deliveryController.obxCustom((state) {
        return ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => (deliveryController.deliveries.isNotEmpty)
                  ? Column(
                      children: List.generate(
                          deliveryController.deliveries.length, (index) {
                        Delivery delivery =
                            deliveryController.deliveries[index];
                        return ListTile(
                          onTap: (){
                            Get.to(()=> DetailDeliveryPage(idDelivery: delivery.id!,));
                          },
                          shape: const Border(
                              bottom: BorderSide(color: greyColor2, width: 2)),
                          leading: const Icon(
                            Icons.delivery_dining,
                            color: redColor,
                          ),
                          title: Text(
                            "No.Resi: ${delivery.noResi}",
                            style: blackTextFontTitleBold,
                          ),
                          subtitle: Text(
                            "${delivery.products!.length} produk",
                            style: blackTextFont,
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color:  delivery.colorStatus,
                            ),
                            child: Text(
                              "${delivery.status}",
                              style: blackTextFont.copyWith(
                                fontSize: 12,
                                
                              ),
                            ),
                          ),
                        );
                      }),
                    )
                  : const DataNotFoundWidget(),
            ),
          ],
        );
      }, onRefreshData: () {}),
      floatingButton: GestureDetector(
        onTap: () async {
          await Get.to(
            () => const AddDeliveryPage1(),
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
