part of 'shared.dart';

enum TypeSnackbar { success, error, info }

void snackbarCustom(
    {required TypeSnackbar typeSnackbar,
    String? title,
    required String message}) {
  Get.rawSnackbar(
    title: title,
    message: message,
    margin: const EdgeInsets.only(
      top: 10,
      left: defaultMargin,
      right: defaultMargin,
    ),
    duration: const Duration(seconds: 2),
    backgroundColor: (typeSnackbar == TypeSnackbar.error)
        ? redColor
        : ((typeSnackbar == TypeSnackbar.info) ? Colors.amber : Colors.green),
    snackPosition: SnackPosition.TOP,
    snackStyle: SnackStyle.FLOATING,
    borderRadius: 10,
  );
  // Get.snackbar(
  //   title,
  //   message,
  //   margin: const EdgeInsets.only(
  //     top: 10,
  //     left: defaultMargin,
  //     right: defaultMargin,
  //   ),
  //   duration: const Duration(seconds: 2),
  //   backgroundColor: (typeSnackbar == TypeSnackbar.error)
  //       ? redColor
  //       : ((typeSnackbar == TypeSnackbar.info) ? Colors.amber : Colors.green),
  //   colorText: whiteColor,
  // );
}

Future showLoading({String? status}) {
  return EasyLoading.show(
    status: status ?? 'loading...',
    dismissOnTap: true,
    maskType: EasyLoadingMaskType.black,
  );
}

Widget loading(double sized,
    {double diameter = 40, Color? color, double? value}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: diameter,
        width: diameter,
        child: CircularProgressIndicator(
          value: value,
          strokeWidth: sized,
          backgroundColor: color ?? mainColor,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.yellow),
        ),
      ),
    ],
  );
}

Future<File?> getSingleImage(BuildContext context) async {
  final _picker = ImagePicker();
  XFile? pickedFile;

  pickedFile = await _picker.pickImage(
      maxHeight: 1200,
      maxWidth: 630,
      imageQuality: 60,
      source: ImageSource.camera);

  if (pickedFile != null) {
    return File(pickedFile.path);
  } else {
    debugPrint('No image selected');
    return null;
  }
}

Future<List<File>?> getMultiImages(BuildContext context,
    {int? max = 5, int? initLength = 0}) async {
  final _picker = ImagePicker();
  List<XFile>? pickedFiles = [];

  await showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Wrap(
            children: <Widget>[
              Column(
                children: [
                  ListTile(
                    onTap: () async {
                      XFile? pickedFile = await _picker.pickImage(
                          maxHeight: 1200,
                          maxWidth: 630,
                          imageQuality: 60,
                          source: ImageSource.camera);
                      if (pickedFile != null) {
                        pickedFiles!.add(pickedFile);
                      }
                      Get.back();
                    },
                    title: const Text('Kamera'),
                    leading: const Icon(Icons.camera),
                  ),
                  ListTile(
                    onTap: () async {
                      pickedFiles = await _picker.pickMultiImage(
                        maxHeight: 1200,
                        maxWidth: 630,
                        imageQuality: 80,
                      );
                      Get.back();
                    },
                    title: const Text('Galeri'),
                    leading: const Icon(Icons.photo_album),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );

  if (pickedFiles != null && pickedFiles!.isNotEmpty) {
    List<File> resultFile = pickedFiles!.map((e) => File(e.path)).toList();
    int storageEmpty = (max! - initLength!);
    if (storageEmpty > resultFile.length) {
      storageEmpty = resultFile.length;
    }

    List<File> fixResult = resultFile.getRange(0, storageEmpty).toList();
    debugPrint('Length Empty: $storageEmpty, add: ${fixResult.length}');
    return fixResult;
  } else {
    debugPrint('No image selected');
    return null;
  }
}

void dialogCustom({
  String? title,
  String titleLeftButton = "Ya",
  String titleRightButton = "Batal",
  String middleText = "ini mid",
  Future<bool> Function()? onWillPop,
  Widget? content,
  bool isConfirm = false,
  Function()? onLeftButton,
  Function()? onRigthButton,
  Color colorLeftButton = mainColor,
  Color colorRightButton = backgroundColor,
}) {
  Get.defaultDialog(
    title: title!,
    middleText: middleText,
    backgroundColor: backgroundColor,
    onWillPop: onWillPop,
    titlePadding: const EdgeInsets.only(
      top: 20,
    ),
    contentPadding: const EdgeInsets.only(
      right: 20,
      left: 20,
      bottom: 20,
      top: 20,
    ),
    content: (!isConfirm)
        ? content
        : Column(
            children: [
              Text(
                middleText,
                style: blackTextFont,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: const ButtonCustomWidget(
              //         title: titleLeftButton,
              //         color: colorLeftButton,
              //         onPressed: onLeftButton ?? () {},
              //       ),
              //     ),
              //     SizedBox(
              //       width: 20,
              //     ),
              //     Expanded(
              //       child: ButtonCustomWidget(
              //         title: titleRightButton,
              //         color: colorRightButton,
              //         onPressed: onRigthButton ??
              //             () {
              //               Get.back();
              //             },
              //       ),
              //     )
              //   ],
              // ),
            ],
          ),
  );
}

void selectedDate(
  BuildContext context, {
  required Function(DateTime value) onComfirm,
  DateTime? currentTIme,
  maxTime,
  bool isMonth = false,
}) {
  if (!(isMonth)) {
    DatePicker.showDatePicker(
      context,
      // showTitleActions: true,
      minTime: DateTime(1950, 1, 1),
      maxTime: maxTime ?? DateTime(2030, 12, 30),
      onConfirm: (date) {
        onComfirm(date);
      },
      currentTime: currentTIme ?? DateTime.now(),
      locale: LocaleType.id,
    );
  } else {
    // DatePicker.showPicker(
    //   context,
    //   pickerModel: CustomMonthPicker(
    //     currentTime: currentTIme ?? DateTime.now(),
    //     minTime: DateTime(2020, 1, 1),
    //     maxTime: DateTime(2030, 1, 1),
    //     locale: LocaleType.id,
    //   ),
    //   onConfirm: (date) {
    //     onComfirm(date);
    //   },
    // );
  }
}

void selectedDateTime(
  BuildContext context, {
  required Function(DateTime value) onComfirm,
  DateTime? currentTIme,
}) {
  DatePicker.showDateTimePicker(
    context,
    // showTitleActions: true,
    minTime: DateTime.now(),
    maxTime: DateTime.now().add(const Duration(days: 90)),
    onConfirm: (date) {
      onComfirm(date);
    },
    currentTime: currentTIme ?? DateTime.now(),
    locale: LocaleType.id,
  );
}

CurrencyTextInputFormatter currencyFormat() {
  return CurrencyTextInputFormatter(
    locale: 'id',
    decimalDigits: 0,
    symbol: 'Rp ',
  );
}

BoxShadow customShadow() =>  BoxShadow(
      color: accentColor1,
      offset:const Offset(1, -1),
      blurRadius: 10,
    );
