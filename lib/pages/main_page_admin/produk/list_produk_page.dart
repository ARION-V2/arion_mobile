part of '../../pages.dart';

class ListProductPage extends StatelessWidget {
  ListProductPage({Key? key}) : super(key: key);
  final productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      titleAppBar: const Text("Daftar Produk"),
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
                      Get.to(
                        () => AddProductPage(
                          product: product,
                        ),
                      );
                    },
                    child: ProductCardWidget(product: product),
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
          ]),
      floatingButton: GestureDetector(
        onTap: () async {
          await Get.to(() => const AddProductPage());
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


