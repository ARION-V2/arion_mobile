part of 'widgets.dart';

class UpdateImageWidget {
  static double heightInitial = Get.width * 0.4;
  static double widthInitial = Get.width * 0.4;
  static double heightMax = 200;
  static double widthMax = 200;
  static Align buildIconDeleteImage(
      {required int index, required void Function() onTap}) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: blackColor.withOpacity(0.5),
          ),
          child: const Icon(
            Icons.cancel,
            color: whiteColor,
          ),
        ),
      ),
    );
  }

  static Container buildSizedImageFormat({required Widget child}) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 170,
        maxHeight: 170,
      ),
      width: Get.width * 0.4,
      decoration: BoxDecoration(
        color: accentColor1,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  static Widget buildCardFilePhotos({
    required dynamic data,
    required int index,
    required List<File> filePhotos,
    required void Function() deletefilePhoto,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: (index == 0)
            ? (data != null)
                ? (data!.photos!.isEmpty)
                    ? defaultMargin
                    : 10
                : defaultMargin
            : 10,
      ),
      child: UpdateImageWidget.buildSizedImageFormat(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: FileImage(filePhotos[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            UpdateImageWidget.buildIconDeleteImage(
              index: index,
              onTap: deletefilePhoto,
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildCardUrlPhotos({
    required int index,
    required List<String> urlPhotos,
    required void Function() deleteUrlPhoto,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(
          PhotoViewCustom(
            urlPhotos,
            indexInitial: index,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: (index == 0) ? defaultMargin : 10,
        ),
        child: SizedBox(
          child: UpdateImageWidget.buildSizedImageFormat(
            child: Stack(
              children: [
                CacheImageCustom(
                  url: urlPhotos[index],
                  imageBuilder: (_, imageProv) => Container(
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: imageProv,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                UpdateImageWidget.buildIconDeleteImage(
                  index: index,
                  onTap: deleteUrlPhoto,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildCardPhotos({
    required dynamic data,
    String title = "",
    List<String> urlPhotos = const [],
    List<File> filePhotos = const [],
    required Function() getPhoto,
    required void Function(int index) deleteUrlPhoto,
    required void Function(int index) deletefilePhoto,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(
        //     left: defaultMargin,
        //   ),
        //   child: Text(
        //     title,
        //     style: blackTextFontTitle,
        //   ),
        // ),
        // const SizedBox(
        //   height: 8,
        // ),
        SizedBox(
          height: heightInitial,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              if (urlPhotos.isNotEmpty)
                Row(
                  children: List.generate(
                    urlPhotos.length,
                    (index) => UpdateImageWidget.buildCardUrlPhotos(
                      index: index,
                      urlPhotos: urlPhotos,
                      deleteUrlPhoto: () {
                        deleteUrlPhoto(index);
                      },
                    ),
                  ),
                ),
              Row(
                children: List.generate(
                  filePhotos.length,
                  (index) => UpdateImageWidget.buildCardFilePhotos(
                    data: data,
                    index: index,
                    filePhotos: filePhotos,
                    deletefilePhoto: () {
                      deletefilePhoto(index);
                    },
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(
              //     right: defaultMargin,
              //     left: filePhotos.isEmpty ? defaultMargin : 10,
              //   ),
              //   child: GestureDetector(
              //     onTap: getPhoto,
              //     child: UpdateImageWidget.buildSizedImageFormat(
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           const Icon(
              //             Icons.add_photo_alternate_outlined,
              //             color: mainColor,
              //             size: 50,
              //           ),
              //           const SizedBox(height: 5),
              //           Text(
              //             'Tambah Foto',
              //             style: blueTextFontTitleBold,
              //             textAlign: TextAlign.center,
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
