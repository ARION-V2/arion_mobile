part of 'widgets.dart';

class FieldCustomWidget extends StatefulWidget {
  final String? title, hint, subTitle;
  final bool obscureText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final double height;
  final double? width;
  final int? maxLine, maxLength;
  final List<TextInputFormatter>? inputFormater;
  final TextInputType? typeKeyboard;
  final TextAlign? align;
  final bool isCurrency, isShadow,isAutoFocus;
  final TextStyle? style;
  final TextStyle? styleHint, styleTitle;

  final Function(String)? onChange;
  final Color? primaryColor;
  final Widget? suffixIcon;
  final bool enabled;
  final Widget? descSelectionInput;
  final TextInputAction? textInputAction;
  final Color? backgroundColor;
  final BoxDecoration? boxDecoration;
  final Function(String)? onFieldSubmitted;

  const FieldCustomWidget({
    Key? key,
    this.title,
    this.subTitle,
    required this.hint,
    required this.controller,
    this.height = 50,
    this.width,
    this.obscureText = false,
    this.prefixIcon,
    this.maxLine = 1,
    this.inputFormater,
    this.typeKeyboard,
    this.align,
    this.isCurrency = false,
    this.style,
    this.onChange,
    this.primaryColor,
    this.suffixIcon,
    this.enabled = true,
    this.descSelectionInput,
    this.textInputAction,
    this.backgroundColor,
    this.boxDecoration,
    this.onFieldSubmitted,
    this.styleHint,
    this.styleTitle,
    this.maxLength,
    this.isShadow =true,
    this.isAutoFocus =false,
  }) : super(key: key);

  @override
  _FieldCustomWidgetState createState() => _FieldCustomWidgetState();
  static bool validateStructurePassword(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}

class _FieldCustomWidgetState extends State<FieldCustomWidget> {
  bool? isObscureText;

  @override
  void initState() {
    super.initState();
    isObscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: widget.primaryColor ?? mainColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          if (widget.title != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title!,
                  style: widget.styleTitle ?? blackTextFontTitleBold,
                ),
                if (widget.subTitle != null)
                  Text(
                    widget.subTitle!,
                    style: greyTextFont,
                  ),
              ],
            ),
          if (widget.title != null) const SizedBox(height: 10.0),
          Container(
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow:widget.isShadow?  [
                BoxShadow(
                  offset: Offset(1, 4),
                  color: mainColor.withOpacity(0.2),
                  blurRadius: 10,
                ),
              ]:null,
            ),
            height: widget.height,
            width: widget.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.prefixIcon != null)
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: widget.prefixIcon,
                  ),
                Expanded(
                  child: Center(
                    child: TextFormField(
                      controller: widget.controller,
                      textInputAction: widget.textInputAction,
                      maxLength:
                          (widget.maxLength != null) ? widget.maxLength : null,
                      style: widget.style ?? blackTextFontTitle,
                      obscureText: isObscureText!,
                      textAlign: widget.align ?? TextAlign.start,
                      cursorColor: mainColor,
                      enabled: widget.enabled,
                      onChanged: widget.onChange,
                      cursorHeight: 18,
                      showCursor: true,
                      // autofocus: true,
                      autofocus: widget.isAutoFocus,
                      maxLines: widget.maxLine,
                      textAlignVertical: TextAlignVertical.center,
                      onFieldSubmitted: widget.onFieldSubmitted,
                      keyboardType: !widget.isCurrency
                          ? ((widget.typeKeyboard == null)
                              ? (widget.maxLine! > 1)
                                  ? TextInputType.multiline
                                  : TextInputType.text
                              : widget.typeKeyboard)
                          : const TextInputType.numberWithOptions(),
                      inputFormatters: ((widget.inputFormater != null)
                          ? widget.inputFormater
                          : null),
                      decoration: InputDecoration(
                        // errorText: 'Error',
                        isDense: true,
                        border: InputBorder.none,
                        hintText: widget.hint,
                        hintStyle: widget.styleHint ?? greyTextFontTitle,
                      ),
                    ),
                  ),
                ),
                if (widget.suffixIcon != null || widget.obscureText)
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: (widget.suffixIcon != null)
                        ? widget.suffixIcon
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                isObscureText = !isObscureText!;
                              });
                            },
                            child: Icon(
                              !isObscureText!
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: greyColor,
                            ),
                          ),
                  ),
              ],
            ),
          ),
          if (widget.descSelectionInput != null)
            Container(
              margin: const EdgeInsets.only(
                top: 5,
              ),
              child: widget.descSelectionInput,
            ),
        ],
      ),
    );
  }
}
