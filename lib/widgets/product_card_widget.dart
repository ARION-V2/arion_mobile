part of 'widgets.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    Key? key,
    required this.product,
    this.isDelivery = false,
    this.isSelected = false,
    this.onChangeQyt,
  }) : super(key: key);

  final Product product;
  final bool isSelected, isDelivery;
  final Function(int?)? onChangeQyt;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: (isSelected) ?const Color.fromARGB(255, 255, 220, 217) : whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: CacheImageCustom(
                url: product.photo,
                imageBuilder: (_, imageProv) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(5)),
                      color: accentColor1,
                      image:
                          DecorationImage(image: imageProv, fit: BoxFit.cover),
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product.productName}",
                  style: blackTextFontBold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  product.prince!.intToCurrency(),
                  style: redTextFontTitleBold,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Stok : ${product.stock}",
                  style: blackTextFont.copyWith(fontSize: 10),
                ),
                const SizedBox(
                  height: 10,
                ),
                if(isDelivery)
                TextField(
                  onChanged: (value) {
                    if (onChangeQyt != null) {
                      onChangeQyt!((value!='')?int.parse(value):null);
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[0-9]'),
                    ),
                  ],
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Kuantitas",
                    isDense: true,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}


class ProductCardDeliveryWidget extends StatelessWidget {
  const ProductCardDeliveryWidget({
    Key? key,
    required this.productDelivery,
    this.onChangeQyt,
  }) : super(key: key);

  final ProductDelivery productDelivery;
  final Function(int?)? onChangeQyt;

  @override
  Widget build(BuildContext context) {
    Product? product = productDelivery.detailProduct;
    return Card(
      color:  whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: CacheImageCustom(
                url: product?.photo,
                imageBuilder: (_, imageProv) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(5)),
                      color: accentColor1,
                      image:
                          DecorationImage(image: imageProv, fit: BoxFit.cover),
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product?.productName}",
                  style: blackTextFontBold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  product!.prince!.intToCurrency(),
                  style: redTextFontTitleBold,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Kuantitas :  ${productDelivery.quantity}",
                  style: blackTextFont.copyWith(fontSize: 10),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}

