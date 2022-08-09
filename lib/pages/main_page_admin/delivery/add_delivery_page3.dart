part of '../../pages.dart';

class AddDeliveryPage3 extends StatefulWidget {
 const AddDeliveryPage3({
    Key? key,
    required this.products,
    required this.partner,
  }) : super(key: key);
  final List<Product> products;
  final Partner partner;

  @override
  State<AddDeliveryPage3> createState() => _AddDeliveryPage3State();
}

class _AddDeliveryPage3State extends State<AddDeliveryPage3> {
  final courierController = Get.find<CourierController>();
    final deliveryController = Get.find<DeliveryController>();

  User? selectedCourier;

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      titleAppBar: const Text("Pilih Kurir"),
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
                  return CardCourierWidget(
                    courier: courier,
                    isSelected: (selectedCourier==courier),
                    onTap: (){
                      setState(() {
                        selectedCourier =courier;
                      });
                    },
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
      bottomNavigationBar: ButtonBottomDetailItemWidget(
        title1: "Buat Pengiriman",
        onTap1: () {
          if(selectedCourier==null){
            snackbarCustom(typeSnackbar: TypeSnackbar.info, message: "Harap memilih salah satu kurir terlebih dahulu");
          }else{
            List<ProductDelivery> products= widget.products.map((e) => ProductDelivery(productId:e.id,quantity: e.qytDelivery )).toList();
            Delivery delivery = Delivery(
              courierId: selectedCourier!.id!,
              partnerId: widget.partner.id,
              products: products,
              status: "Pending"
            );

            debugPrint("Product Delivery : ${delivery.products!.length}");
            deliveryController.addDelivery(delivery: delivery);
            

          }
        },
      ),
    );
  }
}
