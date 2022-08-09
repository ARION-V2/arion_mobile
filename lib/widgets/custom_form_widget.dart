part of 'widgets.dart';

class FormCustomWidget extends StatelessWidget {
  final String? title, hint, content;
  final Widget? icon, suffixIcon;
  final Function()? onTap;
  final double? height;
  final bool isRequired;
  final bool isLoading;
  final bool arrowForward, arrowForwardEnable;
  final Color? backgroudColor;

  const FormCustomWidget({
    Key? key,
    required this.title,
    required this.hint,
    this.onTap,
    required this.content,
    this.icon,
    this.height,
    this.isRequired = false,
    this.isLoading = false,
    this.suffixIcon,
    this.arrowForward = false,
    this.arrowForwardEnable=false,
    this.backgroudColor ,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: title,
                style: blackTextFontTitleBold,
                children: <TextSpan>[
                  if (isRequired)
                    TextSpan(
                      text: ' *',
                      style: redTextFont.copyWith(),
                    ),
                ],
              ),
            ),
            if (suffixIcon != null) suffixIcon!
            // if (isLoading) loading(2, diameter: 15)
          ],
        ),
        const SizedBox(height: 8.0),
        InkWell(
          onTap: onTap,
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: backgroudColor??whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow:  [
                BoxShadow(
                  offset:const Offset(1, 4),
                  color: accentColor1,
                  blurRadius: 20,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: height ?? 50.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    content ?? hint!,
                    style: (content != null)
                        ? blackTextFontTitle
                        : greyTextFontTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (icon != null) icon!,
                if (arrowForward)
                   Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color:(arrowForwardEnable)? blackColor:greyColor,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
