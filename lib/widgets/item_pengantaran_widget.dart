part of 'widgets.dart';

class ItemPengantaranWidget extends StatelessWidget {
  const ItemPengantaranWidget({
    Key? key,
    this.onTap,
    this.status,
    this.child,
    required this.delivey,
  }) : super(key: key);
  final Function()? onTap;
  final Widget? status, child;
  final Delivery? delivey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        width: Get.width,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 3),
                  color: redColor.withOpacity(0.2),
                  blurRadius: 10)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'No. Resi: ${delivey!.noResi}',
                    style: blackTextFontTitleBold,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (status != null) status!,
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${delivey!.partner!.fullName}',
              style: blackTextFontTitle,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${delivey!.partner!.address}',
              style: blackTextFont,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${delivey!.partner!.noHp}',
              style: blackTextFont,
            ),
            const SizedBox(
              height: 5,
            ),
            if(delivey!.nextDeliveryId!=null)
            Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: accentColor1,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Tujuan Berikutnya : ",
                      style: blackTextFont,
                      children: [
                        TextSpan(
                          text: "${delivey!.nameNextDeliveryPartner}",
                          style: blackTextFontBold
                        )
                      ]
                    ),
                  ),
               const   SizedBox(
                    height: 5,
                  ),
                  if(delivey?.distance!=null)
                  Text(" Jarak : ${delivey?.distance!.toStringAsFixed(3)} km", style: blackTextFontBold,)
                ],
              ),
            ),
            
            if (delivey!.direction != null)
              Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Jarak : ${delivey?.direction?.totalDistance.toString()} dari anda ( ${delivey?.direction?.totalDuration} )",
                    style: blackTextFontBold,
                  ),
                ],
              ),
            const SizedBox(
              height: 5,
            ),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
