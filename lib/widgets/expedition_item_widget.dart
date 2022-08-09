part of 'widgets.dart';

class ExpedisionItem extends StatelessWidget {
  final String urlLogo, title;
  final bool value, isSetService;
  final Function(bool value)? onChanged;
  final String? suffixText;

  const ExpedisionItem(
      {Key? key,
      required this.urlLogo,
      required this.title,
      required this.value,
      this.onChanged,
      this.isSetService = true,
      this.suffixText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accentColor1, width: 2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CacheImageCustom(
                url: urlLogo,
                imageBuilder: (_, imageProv) => SizedBox(
                  height: 30,
                  width: 30,
                  child: Image(
                    image: imageProv,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: blackTextFont,
              )
            ],
          ),
          if (suffixText != null)
            Text(
              suffixText!,
              style: blackTextFontTitleBold,
            ),
          if (isSetService)
            SizedBox(
              height: 20,
              width: 40,
              child: SwitchCustomWidget(
                value: value,
                onChanged: onChanged ?? (value) {},
              ),
            ),
        ],
      ),
    );
  }
}
