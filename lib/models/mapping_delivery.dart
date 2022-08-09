import 'package:arion/models/delivery.dart';
import 'package:arion/models/gudang.dart';

import 'direction.dart';

class MappingDelivery {
  Gudang? fromGudang;
  Gudang? toGudang;
  Delivery? fromDelivery;
  Delivery? nextDelivery;
  double? distance;
  Directions? direction;

  MappingDelivery({
    this.fromGudang,
    this.toGudang,
    this.fromDelivery,
    this.nextDelivery,
    this.direction,
  });

  MappingDelivery.fromJson(Map<String, dynamic> json) {
    fromGudang = (json['form_gudang'] != null)
        ? Gudang.fromJson(json['form_gudang'])
        : null;
    toGudang =
        (json['to_gudang'] != null) ? Gudang.fromJson(json['to_gudang']) : null;
    fromDelivery = (json['delivery_from'] != null)
        ? Delivery.fromJson(json['delivery_from'])
        : null;
    nextDelivery = (json['delivery_next'] != null)
        ? Delivery.fromJson(json['delivery_next'])
        : null;
    distance = json['distance'];
  }

  MappingDelivery copyWith({
    Gudang? fromGudang,
    Gudang? toGudang,
    Delivery? fromDelivery,
    Delivery? nextDelivery,
    double? distance,
    Directions? direction,
  })  {
    return MappingDelivery(
      fromGudang: fromGudang ?? this.fromGudang,
      toGudang: toGudang ?? this.toGudang,
      fromDelivery: fromDelivery ?? this.fromDelivery,
      nextDelivery: nextDelivery ?? this.nextDelivery,
      direction: direction ?? this.direction,
    );
  }
}
