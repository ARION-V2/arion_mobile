part of 'widgets.dart';

class PhotoViewCustom extends StatefulWidget {
  final int indexInitial;
  final List<String> photos;
  const PhotoViewCustom(
    this.photos, {
    Key? key,
    this.indexInitial = 0,
  }) : super(key: key);

  @override
  State<PhotoViewCustom> createState() => _PhotoViewCustomState();
}

class _PhotoViewCustomState extends State<PhotoViewCustom> {
    late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.indexInitial);
  }
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
      controller: pageController,
      itemCount: widget.photos.length,
      itemBuilder: (_, index) => CacheImageCustom(
        url: widget.photos[index],
        imageBuilder: (_, imagePerov) {
          return PhotoView(
            imageProvider: imagePerov,
          );
        },
      ),
    ),
    );
  }
}
