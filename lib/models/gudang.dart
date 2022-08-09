


class Gudang {
  int? id;
  String? namaGudang;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;

  Gudang(
      {this.id,
      this.namaGudang,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt});

  Gudang.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaGudang = json['nama_gudang'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_gudang'] = this.namaGudang;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}