part of 'widgets.dart';

class VerticalMenuItem extends StatelessWidget {
  final Widget icon;
  final String text;
  final Function() onTap;
  const VerticalMenuItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      // color: accentColor2,
      elevation: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(
        horizontal: defaultMargin,
        // vertical: 5,
      ),
      onPressed:onTap ,
      child: Row(
        children: [
          SizedBox(
            width: 35,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: icon,
            ),
          ),
          Text(
            text,
            style: blackTextFontTitle,
          )
        ],
      ),
    );
    // return ElevatedButton(
    //   style: ElevatedButton.styleFrom(
    //     primary: whiteColor,
    //     elevation: 0,
    //     padding: const EdgeInsets.symmetric(
    //       horizontal: defaultMargin,
    //       vertical: 5,
    //     ),
    //   ),
    //   onPressed: onTap,
    //   child: Row(
    //     children: [
    //       SizedBox(
    //         width: 35,
    //         child: Align(
    //           alignment: Alignment.bottomLeft,
    //           child: icon,
    //         ),
    //       ),
    //       Text(
    //         text,
    //         style: blackTextFontTitle,
    //       )
    //     ],
    //   ),
    // );
  }
}
