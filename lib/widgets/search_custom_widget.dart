part of 'widgets.dart';

class SearchCustomWidget extends StatefulWidget {
  const SearchCustomWidget({
    Key? key,
    required this.controller,
    this.hint = "Apa yang anda cari?",
    this.isShadow = true,
    this.backgroundColor = whiteColor,
    this.height = 45,
    this.onSubmitted,
    this.isEnable = true,
    this.isAutoFocus =false,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final bool isShadow;
  final Color backgroundColor;
  final double height;
  final bool isEnable, isAutoFocus;
  final Function(String)? onSubmitted;
  @override
  State<SearchCustomWidget> createState() => _SearchCustomWidgetState();
}

class _SearchCustomWidgetState extends State<SearchCustomWidget> {
  bool isValue = false;
  @override
  Widget build(BuildContext context) {
    return FieldCustomWidget(
      height: widget.height,
      hint: widget.hint,
      controller: widget.controller,
      backgroundColor: widget.backgroundColor,
      isShadow: widget.isShadow,
      onFieldSubmitted: widget.onSubmitted,
      enabled: widget.isEnable,
      isAutoFocus: widget.isAutoFocus,
      onChange: (value) {
        setState(() {
          isValue = (value.trim().isNotEmpty);
        });
        if (widget.onSubmitted != null) {
          widget.onSubmitted!(value);
        }
      },
      prefixIcon: const Icon(
        Icons.search,
        color: greyColor,
      ),
      suffixIcon: (isValue)
          ? InkWell(
              onTap: () {
                setState(() {
                  isValue = false;
                });
                widget.controller.clear();

                if (widget.onSubmitted != null) {
                  widget.onSubmitted!("value");
                }
              },
              child: const Icon(
                Icons.close,
                color: mainColor,
              ),
            )
          : null,
    );
  }
}
