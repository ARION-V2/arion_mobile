class TspAnnaling {
	List<UrutanTujuan>? urutanTujuan;
	List<int>? urutan;
	double? jarak;
	DistanceMatrix? distanceMatrix;

	TspAnnaling({this.urutanTujuan, this.urutan, this.jarak,  this.distanceMatrix});

	TspAnnaling.fromJson(Map<String, dynamic> json) {
		if (json['urutan_tujuan'] != null) {
			urutanTujuan = <UrutanTujuan>[];
			json['urutan_tujuan'].forEach((v) { urutanTujuan!.add( UrutanTujuan.fromJson(v)); });
		}
		urutan = json['urutan'].cast<int>();
		jarak = (json['jarak'] is int)?(json['jarak'] as int).toDouble():json['jarak'];
		if (json['distance_matrix'] != null) {
      distanceMatrix = DistanceMatrix.fromJson(json);
		}
	}
}

class UrutanTujuan {
	String? fromAddress;
	String? toAddresses;
	double? jarak;

	UrutanTujuan({this.fromAddress, this.toAddresses, this.jarak});

	UrutanTujuan.fromJson(Map<String, dynamic> json) {
		fromAddress = json['from_address'];
		toAddresses = json['to_addresses'];
		jarak =(json['jarak'] is int)?(json['jarak'] as int).toDouble():json['jarak'];
	}
}
class DistanceMatrix {

  List<List<double>>? matrix;

	DistanceMatrix.fromJson(Map<String, dynamic> json) {
    matrix = (json['distance_matrix'] as Iterable).map((e) => (e as List).map((e) => (e is int)?e.toDouble():(e as double)).toList()).toList(); 
	}
}