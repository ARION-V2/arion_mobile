part of '../../pages.dart';

class DaftarRiwayatPage extends StatefulWidget {
  const DaftarRiwayatPage({Key? key}) : super(key: key);

  @override
  State<DaftarRiwayatPage> createState() => _DaftarRiwayatPageState();
}

class _DaftarRiwayatPageState extends State<DaftarRiwayatPage> {
  final deliveriesController = Get.find<DeliveryController>();
  @override
  void initState() {
    super.initState();
    // deliveriesController.getDoneDeliveries();
  }
  @override
  Widget build(BuildContext context) {
    return deliveriesController.obxCustom(
       (state) {
        return Obx(
        () {
            return GeneralPage(
              titleAppBar:  Text("Riwayat POB (${deliveriesController.doneDeliveriesModel.length})"),
              backgroundColorAppBar: mainColor,
              body: ListView(
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                ( deliveriesController.doneDeliveriesModel.isEmpty)?const DataNotFoundWidget():  Column(
                    children: List.generate(
                      deliveriesController.doneDeliveriesModel.length,
                      (index) => ItemPengantaranWidget(
                        onTap: () {
                          Get.to(
                            () =>  DetailRiwayatPage(delivery:  deliveriesController.doneDeliveriesModel[index] ),
                          );
                        },
                        status: Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 221, 252, 185),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "BERHASIL",
                            style: blackTextFont.copyWith(color: Color.fromARGB(255, 39, 186, 44)),
                          ),
                        ),
                        delivey: deliveriesController.doneDeliveriesModel[index],
                        child: Column(
                          children: [
                            if(deliveriesController.doneDeliveriesModel[index].dateReceived!=null)
                            Text(
                              "Paket diterima pada ${DateTime.parse(deliveriesController.doneDeliveriesModel[index].dateReceived!).toUtc().toLocal().dateAndTime}",
                              style: greyTextFont.copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            );
          }
        );
      }, onRefreshData: () {  }
    );
  }
}
