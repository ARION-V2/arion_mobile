part of 'widgets.dart';

typedef DropDownResult = void Function(String value);

class DropDownWidget extends StatefulWidget {
  final List<String> list;
  final DropDownResult result;
  final String hint;
  final String title;
  final bool isRequired;
  final bool isInit;
  final Widget? suffixIcon;
  final String? value;
  const DropDownWidget({
    Key? key,
    required this.title,
    required this.list,
    required this.result,
    required this.hint,
    this.isRequired = false,
    this.isInit = false,
    this.suffixIcon,
   required this.value,
  }) : super(key: key);
  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: widget.title,
                style: blackTextFontTitleBold,
                children: <TextSpan>[
                  if (widget.isRequired)
                    TextSpan(
                      text: ' *',
                      style: redTextFont.copyWith(),
                    ),
                ],
              ),
            ),
            if (widget.suffixIcon != null) widget.suffixIcon!,
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          height: 50,
          width: Get.width,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow:  [
              BoxShadow(
                offset: Offset(1, 4),
                color: mainColor.withOpacity(0.2),
                blurRadius: 20,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButton<String>(
            value: widget.value,
            underline: const SizedBox(),
            style: blackTextFontTitle,
            isExpanded: true,
            items: widget.list
                .toSet()
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            hint: Text(
              widget.hint,
              style: widget.isInit ? blackTextFontTitle : greyTextFontTitle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            onChanged: (value) {
              widget.result(value!);
            },
          ),
        ),
      ],
    );
  }
}
