part of '../../pages.dart';

class AddDeliveryPage1 extends StatefulWidget {
  const AddDeliveryPage1({Key? key}) : super(key: key);

  @override
  State<AddDeliveryPage1> createState() => _AddDeliveryPage1State();
}

class _AddDeliveryPage1State extends State<AddDeliveryPage1> {
  final productController = Get.find<ProductController>();

  List<int> selectedProductId = [];
  late List<Product> currentProducts;

  @override
  void initState() {
    super.initState();
    currentProducts = productController.products;
    debugPrint("Length Produk : ${currentProducts.length}");
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      titleAppBar: const Text("Pilih Produk"),
      backgroundColorAppBar: mainColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children:
                  List.generate(productController.products.length, (index) {
                Product product = productController.products[index];
                return GestureDetector(
                  onTap: () {
                    // if (selectedProductId.contains(product.id)) {
                    //   selectedProductId.remove(product.id);
                    // } else {
                    //   selectedProductId.add(product.id!);
                    // }
                    // setState(() {});
                  },
                  child: ProductCardWidget(
                    product: product,
                    isDelivery: true,
                    isSelected: selectedProductId.contains(product.id),
                    onChangeQyt: (value) {
                      if (value != null) {
                        if (!selectedProductId.contains(product.id)) {
                          selectedProductId.add(product.id!);
                        }
                        currentProducts = currentProducts.map((e) {
                          if (e.id == product.id) {
                            return product.copyWith(qytDelivery: value);
                          } else {
                            return e;
                          }
                        }).toList();
                        setState(() {});
                      } else {
                        currentProducts = currentProducts.map((e) {
                          if (e.id == product.id) {
                            return product.copyWith(qytDelivery: null);
                          } else {
                            return e;
                          }
                        }).toList();

                        if (selectedProductId.contains(product.id)) {
                          selectedProductId.remove(product.id);
                        }
                        setState(() {});
                      }
                    },
                  ),
                );
              }),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
      bottomNavigationBar: ButtonBottomDetailItemWidget(
        title1: "Lanjutkan",
        onTap1: () {
          if (selectedProductId.isEmpty) {
            snackbarCustom(
                typeSnackbar: TypeSnackbar.info,
                message: "Harap memilih minimal 1 produk");
          } else {
            List<Product> productsSelected = [];
            for (int productId in selectedProductId) {
              debugPrint("selected Product: $productId");
              productsSelected.add(currentProducts
                  .firstWhere((element) => element.id == productId));
            }
            for (var product in currentProducts) {
              debugPrint("product all id : ${product.id}");
            }
            List<Product> products = productsSelected
                .where((element) => element.qytDelivery == null)
                .toList();

            if (products.isNotEmpty) {
              snackbarCustom(
                  typeSnackbar: TypeSnackbar.info,
                  message:
                      "Harap mengisi kuantitas pengiriman pada produk yang dipilih");
            } else {
              Get.to(() => AddDeliveryPage2(products: productsSelected));
            }
          }
        },
      ),
    );
  }
}
