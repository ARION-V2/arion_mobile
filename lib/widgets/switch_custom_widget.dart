part of 'widgets.dart';

class SwitchCustomWidget extends StatelessWidget {
  final bool value;
  final Function(bool value) onChanged;
  const SwitchCustomWidget({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 40,
      child: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: mainColor,
        activeTrackColor: accentColor1,
      ),
    );
  }
}
