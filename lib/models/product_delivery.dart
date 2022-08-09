import 'package:arion/models/product.dart';

class ProductDelivery {
  int? id;
  int? deliveryId;
  int? productId;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  Product? detailProduct;

  ProductDelivery(
      {this.id,
      this.deliveryId,
      this.productId,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.detailProduct});

  ProductDelivery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryId = json['delivery_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    detailProduct = (json['detail_product']!=null)?Product.fromJson(json['detail_product']):null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['delivery_id'] = this.deliveryId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['detail_product'] = this.detailProduct;
    return data;
  }
}