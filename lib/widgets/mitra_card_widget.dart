part of 'widgets.dart';

class MitraCardWidget extends StatelessWidget {
  const MitraCardWidget({
    Key? key,
    required this.mitra,
  }) : super(key: key);

  final Partner mitra;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: const EdgeInsets.only(bottom: 20),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Icon(Icons.store, size: 30,color: mainColor,),
           const   SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mitra.marketName!,
                      style: blackTextFontTitleBold,
                    ),
                    Text(
                     mitra.fullName!,
                      style: greyTextFont,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                     mitra.address!,
                      style: blackTextFont,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Tlp. ${mitra.noHp}",
                      style: blackTextFont,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
