import 'package:google_maps_flutter/google_maps_flutter.dart';

class Partner {
  int? id;
  String? fullName;
  String? marketName;
  String? address;
  String? noHp;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;

  Partner(
      {this.id,
      this.fullName,
      this.marketName,
      this.address,
      this.noHp,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt});

  LatLng get locationLatLng{
    return LatLng(double.tryParse(latitude!)??0.0, double.tryParse(longitude!)??0.0);
  }

  Partner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    marketName = json['market_name'];
    address = json['address'];
    noHp = json['no_hp'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['market_name'] = this.marketName;
    data['address'] = this.address;
    data['no_hp'] = this.noHp;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  Partner copyWith({
    String? fullName,
    String? marketName,
    String? address,
    String? noHp,
    String? latitude,
    String? longitude,
  }) {
    return Partner(
      id: id,
      fullName: fullName ?? this.fullName,
      marketName: marketName ?? this.marketName,
      address: address ?? this.address,
      noHp: noHp ?? this.noHp,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
