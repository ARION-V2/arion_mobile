part of 'widgets.dart';

class DataSearchWidget extends StatelessWidget {
  final String? message;
  final String? subMessage;

  const DataSearchWidget({Key? key, this.message, this.subMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              const  Icon(Icons.search, size: 80,),
                Text(
                  message ?? 'Silahkan untuk melakukan pencarian',
                  style: greyTextFontTitle,
                ),
                if (subMessage != null)
                  Text(
                    subMessage!,
                    style: greyTextFont,
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
