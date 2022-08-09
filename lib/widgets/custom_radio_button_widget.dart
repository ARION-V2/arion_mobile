part of 'widgets.dart';


class RadioButtonWidget extends StatelessWidget {
  const RadioButtonWidget(
      {Key? key,
      required this.selected,
      required this.onTap1,
      required this.onTap2,
      required this.title1,
      required this.title2,
      })
      : super(key: key);

  final bool? selected;
  final String title1, title2;
  final Function() onTap1, onTap2;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomSmallButtonWidget(
            title: title1,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            // width: widthButton ?? 80,
            borderColor: (selected != null)
                ? !selected!
                    ? accentColor1
                    : null
                : accentColor1,
            primaryColor: (selected != null)
                ? !selected!
                    ? whiteColor
                    : mainColor
                : whiteColor,
            textStyle: (selected != null)
                ? !selected!
                    ? blueTextFont
                    : whiteTextFont
                : blueTextFont,
            onTap: onTap1),
        const SizedBox(
          width: 10,
        ),
        CustomSmallButtonWidget(
          title: title2,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
         
          borderColor: (selected != null)
              ? selected!
                  ? accentColor1
                  : null
              : accentColor1,
          primaryColor: (selected != null)
              ? selected!
                  ? whiteColor
                  : mainColor
              : whiteColor,
          textStyle: (selected != null)
              ? selected!
                  ? blueTextFont
                  : whiteTextFont
              : blueTextFont,
          onTap: onTap2,
        ),
      ],
    );
  }
}