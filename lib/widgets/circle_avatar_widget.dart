part of 'widgets.dart';

class CircleAvatarCustom extends StatelessWidget {
  final String? url;
  final double diameter, sizeIcon;
  final File? imageFile;
  final bool isPerson;
  const CircleAvatarCustom({
    Key? key,
    required this.url,
    required this.diameter,
    this.imageFile,
    this.isPerson = false,
    this.sizeIcon =30
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: diameter,
      width: diameter,
      child: (url != null)
          ? CachedNetworkImage(
              imageUrl: url!,
              imageBuilder: (_, imageProv) {
                return CircleAvatar(
                  foregroundImage: imageProv,
                );
              },
              placeholder: (context, url) => Shimmer.fromColors(
                child: const CircleAvatar(
                  backgroundColor: whiteColor,
                ),
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
              ),
              errorWidget: (context, url, error) {
                debugPrint("Photo Error => url: $url  error : $error",);
                return const CircleAvatar(
                backgroundColor: whiteColor,
                child: Center(
                  child: Icon(Icons.error),
                ),
              );}
            )
          : CircleAvatar(
              foregroundImage: (imageFile != null)
                  ? FileImage(
                      File(imageFile!.path),
                    )
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (!isPerson)
                      ?  Icon(
                          Icons.image,
                          size: sizeIcon,
                          color: greyColor,
                        )
                      :  Icon(
                          Icons.person,
                          size: sizeIcon,
                          color: greyColor,
                        ),
                  // Text('Tidak ada logo', style: greyTextFontTitle),
                ],
              ),
              backgroundColor: accentColor1,
            ),
    );
  }
}
