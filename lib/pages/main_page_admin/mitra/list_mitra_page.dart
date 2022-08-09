part of '../../pages.dart';

class ListMitraPage extends StatefulWidget {
  const ListMitraPage({Key? key}) : super(key: key);

  @override
  State<ListMitraPage> createState() => _ListMitraPageState();
}

class _ListMitraPageState extends State<ListMitraPage> {
  late Future<ApiReturnValue> getPartner;
  final partnerController = Get.find<PartnerController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      titleAppBar: const Text("Daftar Mitra"),
      backgroundColorAppBar: mainColor,
      onRefresh: () async {
        setState(() {});
      },
      body: partnerController.obxCustom(
         (state) {
          return GetX<PartnerController>(
            builder:(controller){
              List<Partner> listPartner = controller.partners;
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  (listPartner.isEmpty)
                      ? const DataNotFoundWidget()
                      : Column(
                          children: List.generate(
                            listPartner.length,
                            (index) => GestureDetector(
                              onTap: () {
                                Get.to(
                                  AddMitraPage(
                                    partner: listPartner[index],
                                  ),
                                );
                              },
                              child: MitraCardWidget(mitra: listPartner[index]),
                            ),
                          ),
                        ),
                ],
              );
            },
          );
          
        }, onRefreshData: () { 
          partnerController.getAllPartner();
         }
      ),
      floatingButton: GestureDetector(
        onTap: () async {
          await Get.to(() => const AddMitraPage());

          setState(() {
            getPartner = PartnerServices().getPartners();
          });
        },
        child: const SizedBox(
          height: 60,
          width: 60,
          child: CircleAvatar(
            backgroundColor: mainColor,
            child: Icon(
              Icons.add,
              color: whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}

