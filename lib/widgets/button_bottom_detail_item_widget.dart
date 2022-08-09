part of 'widgets.dart';

class ButtonBottomDetailItemWidget extends StatelessWidget {
  final String title1;
  final String? title2;
  final Function()? onTap1, onTap2;
  const ButtonBottomDetailItemWidget(
      {Key? key, required this.title1, this.title2, this.onTap1, this.onTap2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration:  BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            offset:const Offset(0, -1),
            blurRadius: 10,
            color: accentColor1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomButtonWidget(
              title: title1,
              onTap: onTap1 ?? () {},
            ),
          ),
          if(title2 != null)
          const SizedBox(
            width: 20,
          ),
          (title2 != null)
              ? CustomButtonWidget(
                  width: 100,
                  title: title2!,
                  primaryColor: redColor,
                  onTap: onTap2 ?? () {},
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
