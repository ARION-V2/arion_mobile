part of 'widgets.dart';

class CardCourierWidget extends StatelessWidget {
  const CardCourierWidget({
    Key? key,
    required this.courier,
     this.isSelected=false,
    required this.onTap,
  }) : super(key: key);

  final User courier;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor:(isSelected)?const  Color.fromARGB(255, 255, 220, 217):null,
      onTap:onTap,
      leading: CircleAvatarCustom(
        url: courier.photo,
        diameter: 50,
        isPerson: true,
      ),
      title: Text(
        "${courier.name}",
        style: blackTextFontTitle,
      ),
      subtitle: Text(
        "${courier.noHp}",
        style: blackTextFont,
      ),
    );
  }
}