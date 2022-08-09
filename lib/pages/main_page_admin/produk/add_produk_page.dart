part of '../../pages.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({
    Key? key,
    this.product,
  }) : super(key: key);
  final Product? product;

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final productController = Get.find<ProductController>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descrptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stokController = TextEditingController();

  File? photo;
  String? urlPhoto;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      nameController.text = widget.product!.productName!;
      descrptionController.text = widget.product!.description!;
      priceController.text = widget.product!.prince!.intToCurrency();
      urlPhoto = widget.product?.photo;
      stokController.text = widget.product!.stock!.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      titleAppBar:
          Text((widget.product != null) ? "Ubah data" : "Tambah Produk"),
      actionsAppBar: [
        if (widget.product != null)
          TextButton(
            onPressed: () async {
              productController.deleteProduct(widget.product!);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                "Hapus",
                style: whiteTextFontBold,
              ),
            ),
          )
      ],
      backgroundColorAppBar: mainColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              children: [
                CircleAvatarCustom(
                  url: urlPhoto,
                  imageFile: photo,
                  diameter: 150,
                ),
                TextButton(
                  onPressed: () async {
                    // controller.updatePhotoProfile(context);
                    photo = await getSingleImage(context);
                    setState(() {});
                  },
                  child: Text(
                    "Pilih Foto",
                    style: blueTextFontBold,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          FieldCustomWidget(
            title: "Nama Produk",
            hint: "Masukan nama produk",
            controller: nameController,
          ),
          const SizedBox(
            height: 15,
          ),
          FieldCustomWidget(
            title: "Harga",
            hint: "Masukan harga",
            controller: priceController,
            typeKeyboard: TextInputType.number,
            inputFormater: [
              currencyFormat(),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          FieldCustomWidget(
            title: "Deskripsi",
            hint: "Masukan deskripsi",
            controller: descrptionController,
          ),
          const SizedBox(
            height: 15,
          ),
          FieldCustomWidget(
            title: "Stok",
            hint: "Masukan stok",
            controller: stokController,
            typeKeyboard: TextInputType.number,
            inputFormater: [
              FilteringTextInputFormatter.allow(
                RegExp('[0-9]'),
              ),
            ],
          ),
         
          const SizedBox(
            height: 40,
          ),
        ],
      ),
      bottomNavigationBar: ButtonBottomDetailItemWidget(
          title1: "Simpan",
          onTap1: () async {
            if (!(nameController.text.trim() != "" &&
                priceController.text.trim() != '' &&
                descrptionController.text.trim() != '' &&
                stokController.text.trim() != '')) {
              snackbarCustom(
                  typeSnackbar: TypeSnackbar.error,
                  message: "Harap untuk mengisi seluruh data terlebih dahulu");
            }
            Product productRequest;
            if (widget.product != null) {
              productRequest = widget.product!.copyWith(
                productName: nameController.text,
                prince: priceController.text.toIntCurrency(),
                description: descrptionController.text,
                stock: int.parse(stokController.text),
              );
            } else {
              productRequest = Product(
                productName: nameController.text,
                prince:  priceController.text.toIntCurrency(),
                description: descrptionController.text,
                stock: int.parse(stokController.text),
              );
            }

            await productController.addProduct(
              product: productRequest,
              file: photo,
            );
          }),
    );
  }
}
