part of '../../pages.dart';

class TandaTanganPage extends StatefulWidget {
  const TandaTanganPage({Key? key}) : super(key: key);

  @override
  State<TandaTanganPage> createState() => _TandaTanganPageState();
}

class _TandaTanganPageState extends State<TandaTanganPage> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      titleAppBar: const Text("Tanda Tangan"),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: SfSignaturePad(
                    key: signatureGlobalKey,
                    backgroundColor: Colors.white,
                    strokeColor: Colors.black,
                    minimumStrokeWidth: 1.0,
                    maximumStrokeWidth: 4.0,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                    onPressed: _handleSaveButtonPressed,
                    child: const Text('Simpan'),
                  ),
                  TextButton(
                    onPressed: _handleClearButtonPressed,
                    child: const Text('Hapus'),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  void _handleSaveButtonPressed() async {
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);

    Uint8List imageInUnit8List = bytes!.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/image.png').create();
    file.writeAsBytesSync(imageInUnit8List);
    Get.back(
      result: file,
    );
  }
}
