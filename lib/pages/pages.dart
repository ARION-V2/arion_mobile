import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:arion/controller/courier_controller.dart';
import 'package:arion/controller/devlivery_controller.dart';
import 'package:arion/controller/location_controller.dart';
import 'package:arion/controller/partner_controller.dart';
import 'package:arion/extensions/extensions.dart';
import 'package:arion/main.dart';
import 'package:arion/models/Tsp_anneling.dart';
import 'package:arion/models/delivery.dart';
import 'package:arion/models/mapping_delivery.dart';
import 'package:arion/models/partner.dart';
import 'package:arion/models/product.dart';
import 'package:arion/models/product_delivery.dart';
import 'package:arion/models/user.dart';
import 'package:arion/pages/intro/wrapper_login.dart';
import 'package:arion/pages/maps/mapping/polymarker_maps_page.dart';
import 'package:arion/pages/maps/maps_location/bindings/maps_location_binding.dart';
import 'package:arion/pages/maps/maps_location/controllers/maps_location_controller.dart';
import 'package:arion/pages/maps/maps_location/views/maps_location_view.dart';
import 'package:arion/pages/maps/selectLocation/bindings/select_location_binding.dart';
import 'package:arion/pages/maps/selectLocation/views/select_location_view.dart';
import 'package:arion/service/anneling_services.dart';
import 'package:arion/service/delivery_services.dart';
import 'package:arion/utils/api_return_value.dart';
import 'package:arion/widgets/widgets.dart';
import 'package:change_app_package_name/file_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:map_launcher/map_launcher.dart' as mapLauncher;
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;


import '../controller/product_controller.dart';
import '../controller/user_controller.dart';
import '../service/partner_services.dart';
import '../shared/shared.dart';

part 'intro/splash_screeen.dart';
part 'main_page_kurir/dashboard/dashboar_page.dart';
part 'intro/login_page.dart';
part 'main_page_kurir/daftar_antar/daftar_pengantaran_page.dart';
part 'main_page_kurir/daftar_antar/detail_pengantaran_page.dart';
part 'main_page_kurir/daftar_antar/antar_paket_selesai_page.dart';
part 'main_page_kurir/daftar_antar/tanda_tangan_page.dart';
part 'main_page_kurir/riwayat_pod/daftar_riwayat_page.dart';
part 'main_page_kurir/riwayat_pod/detail_riwayat_page.dart';
part 'main_page_kurir/daftar_antar/matrix_jarak_page.dart';


part 'main_page_admin/dashboard/dashboar_page.dart';

part 'main_page_admin/kurir/add_kulir_page.dart';
part 'main_page_admin/kurir/list_kulir_page.dart';
part 'main_page_admin/mitra/add_mitra_page.dart';
part 'main_page_admin/mitra/list_mitra_page.dart';
part 'main_page_admin/produk/add_produk_page.dart';
part 'main_page_admin/produk/list_produk_page.dart';

part 'main_page_admin/delivery/list_delivery_page.dart';
part 'main_page_admin/delivery/add_delivery_page1.dart';
part 'main_page_admin/delivery/add_delivery_page2.dart';
part 'main_page_admin/delivery/add_delivery_page3.dart';
part 'main_page_admin/delivery/detail_delivery_page.dart';
