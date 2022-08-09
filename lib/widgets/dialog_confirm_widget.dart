part of 'widgets.dart';

class ShowDialongComfirm extends StatelessWidget {
  const ShowDialongComfirm({
    Key? key,
    this.customWidgetText,
    this.textMessage,
    this.comfirmOkColor,
    required this.onConfirmOk,
    
  }) : super(key: key);
  final Widget? customWidgetText;
  final String? textMessage;
  final Color? comfirmOkColor;
  final Function() onConfirmOk;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          width: Get.width,
          decoration: BoxDecoration(
              color: whiteColor, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
           customWidgetText??   Text(
              textMessage??  "no message",
              style: blackTextFont,
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Text(
                      "Tidak",
                      style: blackTextFontTitleBold.copyWith(
                        color: Color(0xFF666666),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  GestureDetector(
                    onTap: onConfirmOk,
                    child: Text(
                      "Ya",
                      style: blackTextFontTitleBold.copyWith(
                        color:comfirmOkColor?? mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}