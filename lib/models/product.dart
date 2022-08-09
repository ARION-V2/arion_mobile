import 'package:equatable/equatable.dart';

class Product extends Equatable {
  int? id;
  String? productName;
  String? description;
  String? photo;
  int? prince;
  int? stock;
  String? createdAt;
  String? updatedAt;
  int? qytDelivery;

  Product({
    this.id,
    this.productName,
    this.description,
    this.photo,
    this.prince,
    this.stock,
    this.createdAt,
    this.updatedAt,
    this.qytDelivery,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    description = json['description'];
    photo = json['photo'];
    prince = json['prince'];
    stock = json['stock'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['description'] = this.description;
    data['prince'] = this.prince;
    data['stock'] = this.stock;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  Product copyWith({
    String? productName,
    String? description,
    String? photo,
    int? prince,
    int? stock,
    int? qytDelivery,
  }) {
    return Product(
      id: id,
      productName: productName ?? this.productName,
      description: description ?? this.description,
      photo: photo ?? this.photo,
      prince: prince ?? this.prince,
      stock: stock ?? this.stock,
      createdAt: createdAt,
      updatedAt: updatedAt,
      qytDelivery:qytDelivery,
    );
  }

  @override
  List<Object?> get props => [
        id,
        productName,
        description,
        photo,
        prince,
        stock,
        createdAt,
        updatedAt,
        qytDelivery,
      ];
}
