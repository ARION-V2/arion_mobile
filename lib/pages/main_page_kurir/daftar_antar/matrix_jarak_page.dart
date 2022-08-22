part of '../../pages.dart';

class MatrixJarakPage extends StatefulWidget {
  const MatrixJarakPage({Key? key}) : super(key: key);

  @override
  State<MatrixJarakPage> createState() => _MatrixJarakPageState();
}

class _MatrixJarakPageState extends State<MatrixJarakPage> {
  var deliveryController = Get.find<DeliveryController>();
  List<Delivery>? waitingDeliveriesModel;
  TspAnnaling? matrixDistance;
  @override
  void initState() {
    super.initState();
    waitingDeliveriesModel = deliveryController.waitingDeliveriesModel;
    matrixDistance = deliveryController.resultMatrix.value;
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      titleAppBar: const Text("Distance Matrix"),
      backgroundColorAppBar: mainColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          const SizedBox(
            height: 20,
          ),
          Text("Total Jarak Optimal = ${matrixDistance?.jarak!.toInt()} m"),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: DataTable(
                columnSpacing: 50,
                dataRowHeight: 50,
                headingRowColor:
                    MaterialStateProperty.resolveWith<Color>((states) {
                  return mainColor; // Use the default value.
                }),
                dataRowColor: MaterialStateColor.resolveWith(
                  (states) => whiteColor,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                headingTextStyle: whiteTextFontBold,
                dataTextStyle: blackTextFont,
                horizontalMargin: 10,
                dividerThickness: 3,
                columns: [
                      const DataColumn(
                        label: Text("X/Y"),
                      ),
                    ] +
                    [
                      const DataColumn(
                        label: Text("Gudang"),
                      ),
                    ] +
                    deliveryController.waitingDeliveriesModel
                        .map(
                          (element) => DataColumn(
                            label: Text("${element.partner!.marketName}"),
                          ),
                        )
                        .toList(),
                rows: [
                      DataRow(
                        cells: [
                              const DataCell(
                                Text("Gudang"),
                              ),
                            ] +
                            matrixDistance!.distanceMatrix!.matrix![0]
                                .map(
                                  (e) => DataCell(
                                    Text("${e.toInt()}"),
                                  ),
                                )
                                .toList(),
                      ),
                    ] + mappingDataRowMatrix()
              ),
            ),
          )
        ],
      ),
    );
  }

  List<DataRow> mappingDataRowMatrix() {
    List<DataRow> result = [];

    for (var i = 0; i < waitingDeliveriesModel!.length; i++) {
      result.add(
        DataRow(
          cells: [
            DataCell(
              Text("${waitingDeliveriesModel![i].partner!.marketName}"),
            ),
          ] + mappingDataCellMatrix(i+1),
        ),
      );
    }
    return result;
  }

  List<DataCell> mappingDataCellMatrix(int index) {
    List<DataCell> result = [];

    if (index != 0) {
        for (var element in matrixDistance!.distanceMatrix!.matrix![index]) {
          result.add(
            DataCell(
              Text("${element.toInt()}"),
            ),
          );
        }
      }
    return result;
  }
}
