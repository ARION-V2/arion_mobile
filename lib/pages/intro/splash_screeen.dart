part of '../pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var box = GetStorage();
  late String? isLogin;
  @override
  void initState() {
    super.initState();
    isLogin = box.read('token');
    startTime();
  }

  startTime() async {
    return Timer(const Duration(seconds: 2), navigationPage);
  }

  void navigationPage() {
    // Get.offAllNamed(Routes.LOGIN);
    if (isLogin != null) {
      Get.offAll(() =>  WrapperLogin());
    } else {
      Get.offAll(() => const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/Logo.png',
            fit: BoxFit.cover,
            height: 153,
          ),
        ),
      ),
    );
  }
}
