part of 'widgets.dart';

class InfoDirectionWidget extends StatelessWidget {
  const InfoDirectionWidget({
    Key? key,
    required this.distance,
  }) : super(key: key);

  final double distance;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '${distance.doubleToString()} ',
        style: blackNumberFont.copyWith(
            fontSize: 12, color: mainColor, fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: "${(distance < 1.0) ? 'm' : 'km'} dari anda",
            style: blueTextFont.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
