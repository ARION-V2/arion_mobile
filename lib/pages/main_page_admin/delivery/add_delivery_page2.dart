part of '../../pages.dart';

class AddDeliveryPage2 extends StatefulWidget {
  const AddDeliveryPage2({
    Key? key,
    required this.products,
  }) : super(key: key);
  final List<Product> products;

  @override
  State<AddDeliveryPage2> createState() => _AddDeliveryPage2State();
}

class _AddDeliveryPage2State extends State<AddDeliveryPage2> {
  final partnerController = Get.find<PartnerController>();

  List<Product> selectedProduct = [];

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      titleAppBar: const Text("Pilih Mitra"),
      backgroundColorAppBar: mainColor,
      body: partnerController.obxCustom((state) {
        return GetX<PartnerController>(
          builder: (controller) {
            List<Partner> listPartner = controller.partners;
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              children: [
                const SizedBox(
                  height: 20,
                ),
                (listPartner.isEmpty)
                    ? const DataNotFoundWidget()
                    : Column(
                        children: List.generate(
                          listPartner.length,
                          (index) => GestureDetector(
                            onTap: () {
                              Get.to(
                                () => AddDeliveryPage3(
                                  products: widget.products,
                                  partner: listPartner[index],
                                ),
                              );
                            },
                            child: MitraCardWidget(mitra: listPartner[index]),
                          ),
                        ),
                      ),
              ],
            );
          },
        );
      }, onRefreshData: () {
        partnerController.getAllPartner();
      }),
    );
  }
}
