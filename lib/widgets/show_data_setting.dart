part of 'widgets.dart';

class ShowDataSetting {
  static Widget buildSingelField({
    required String title,
    required String body,
    bool isDivider = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: blackTextFont,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          body,
          style: blackTextFontTitleBold,
        ),
        if (isDivider)
          const Divider(
            color: greyColor,
          ),
      ],
    );
  }
}
