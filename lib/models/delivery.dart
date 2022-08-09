import 'package:arion/models/direction.dart';
import 'package:arion/models/partner.dart';
import 'package:arion/models/product_delivery.dart';
import 'package:arion/models/user.dart';
import 'package:arion/shared/shared.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class Delivery extends Equatable {
  int? id;
  String? noResi;
  int? partnerId;
  int? courierId;
  String? note;
  String? photoReceived;
  String? dateDelivery;
  String? dateReceived;
  String? status;
  String? createdAt;
  String? updatedAt;
  User? courier;
  Partner? partner;
  List<ProductDelivery>? products;
  String? statusReceived;
  Directions? direction;
  double? distance;
  // Delivery? destinationDelivery;
  LatLng? nextLatLngDelivery;
  LatLng? fromLatLngDelivery;
  String? nameFromDeliveryPartner;
  String? nameNextDeliveryPartner;
  int? nextDeliveryId;
  // String? nameFromDeliveryPartner;

  Delivery(
      {this.id,
      this.noResi,
      this.partnerId,
      this.courierId,
      this.note,
      this.photoReceived,
      this.dateDelivery,
      this.dateReceived,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.courier,
      this.products,
      this.partner,
      this.statusReceived,
      this.direction,
      this.distance,
      this.fromLatLngDelivery,
      this.nameFromDeliveryPartner,
      this.nameNextDeliveryPartner,
      this.nextLatLngDelivery,
      this.nextDeliveryId
      // this.destinationDelivery,
      // this.fromLatLngDelivery,
      // this.nameFromDeliveryPartner,
      // this.nextLatLngDelivery,
      });

  Color get colorStatus {
    switch (status) {
      case "Pending":
        return Colors.amber;
      case "On Progress":
        return Colors.blue;
      case "Berhasil":
        return Colors.green;
      case "Gagal":
        return Colors.red;
      default:
        return greyColor;
    }
  }

  Delivery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noResi = json['no_resi'];
    partnerId = json['partner_id'];
    courierId = json['courier_id'];
    note = json['note'];
    photoReceived = json['photo_received'];
    dateDelivery = json['date_delivery'];
    dateReceived = json['date_received'];
    status = json['status'];
    courier = (json['courier'] != null) ? User.fromJson(json['courier']) : null;
    products = (json['products'] != null)
        ? (json['products'] as Iterable)
            .map(
              (e) => ProductDelivery.fromJson(e),
            )
            .toList()
        : null;
    partner =
        (json['partner'] != null) ? Partner.fromJson(json['partner']) : null;
    statusReceived = json['status_received'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['no_resi'] = this.noResi;
    data['partner_id'] = this.partnerId;
    data['courier_id'] = this.courierId;
    data['note'] = this.note;
    data['date_delivery'] = this.dateDelivery;
    data['date_received'] = this.dateReceived;
    data['status'] = this.status;
    data['status_received'] = this.statusReceived;

    if (products != null) {
      for (var i = 0; i < products!.length; i++) {
        debugPrint("Masuk nihhh id ${i + 1} dari ${products!.length}");
        data['add_product[$i][product_id]'] = products![i].productId;
        data['add_product[$i][quantity]'] = products![i].quantity;
      }
    }
    return data;
  }

  Delivery copyWith({
    String? noResi,
    int? partnerId,
    int? courierId,
    String? note,
    String? photoReceived,
    String? dateDelivery,
    String? dateReceived,
    String? status,
    String? statusReceived,
    User? courier,
    List<ProductDelivery>? products,
    Partner? partner,
    Directions? direction,
    double? distance,
    LatLng? nextLatLngDelivery,
    LatLng? fromLatLngDelivery,
    String? nameFromDeliveryPartner,
    String? nameNextDeliveryPartner,
    int? nextDeliveryId,
    // Delivery? destinationDelivery,
  }) {
    return Delivery(
      id: id,
      noResi: noResi ?? this.noResi,
      partnerId: partnerId ?? this.partnerId,
      courierId: courierId ?? this.courierId,
      note: note ?? this.note,
      photoReceived: photoReceived ?? this.photoReceived,
      dateDelivery: dateDelivery ?? this.dateDelivery,
      dateReceived: dateReceived ?? this.dateReceived,
      status: status ?? this.status,
      createdAt: createdAt,
      updatedAt: updatedAt,
      courier: courier ?? this.courier,
      products: products ?? this.products,
      partner: partner ?? this.partner,
      statusReceived: statusReceived ?? this.statusReceived,
      direction: direction ?? this.direction,
      distance: distance ?? this.distance,
      fromLatLngDelivery: fromLatLngDelivery ?? this.fromLatLngDelivery,
      nextLatLngDelivery: nextLatLngDelivery ?? this.nextLatLngDelivery,
      nameFromDeliveryPartner:
          nameFromDeliveryPartner ?? this.nameFromDeliveryPartner,
      nameNextDeliveryPartner:
          nameNextDeliveryPartner ?? this.nameNextDeliveryPartner,
      nextDeliveryId: nextDeliveryId ?? this.nextDeliveryId,
      // nextLatLngDelivery: nextLatLngDelivery ?? this.nextLatLngDelivery,
      // fromLatLngDelivery: fromLatLngDelivery ?? this.fromLatLngDelivery,
      // destinationDelivery: destinationDelivery ?? this.destinationDelivery,
      // nameFromDeliveryPartner:
      //     nameFromDeliveryPartner ?? this.nameFromDeliveryPartner,
    );
  }

  @override
  List<Object?> get props => [
        id,
        noResi,
        partnerId,
        courierId,
        note,
        photoReceived,
        dateDelivery,
        dateReceived,
        status,
        createdAt,
        updatedAt,
        courier,
        products,
        partner,
        direction,
        statusReceived,
        distance,
        fromLatLngDelivery,
        nextLatLngDelivery,
        nameFromDeliveryPartner,
        nameNextDeliveryPartner,
        nextDeliveryId,
        // nextLatLngDelivery,
        // fromLatLngDelivery,
        // destinationDelivery,
        // nameFromDeliveryPartner,
      ];
}
