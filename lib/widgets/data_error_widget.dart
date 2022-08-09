part of 'widgets.dart';

class DataErrorWidget extends StatelessWidget {
  final Function()? onRefresh;

  const DataErrorWidget({Key? key, this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: 50,),
          Text(
            'Jaringan Internet bermasalah.\nSilahkan cek pengaturan jaringan kamu',
            style: greyTextFontTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButtonWidget(
            width: 150,
            title: "Muat Ulang",
            onTap: onRefresh!,
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
