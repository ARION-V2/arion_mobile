part of '../pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          children: [
            const SizedBox(
              height: 100,
            ),
            Center(
              child: Image.asset(
                'assets/Logo.png',
                width: 200,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            FieldCustomWidget(
              hint: 'Username',
              controller: usernameController,
              prefixIcon: const Icon(Icons.person),
            ),
            const SizedBox(
              height: 25,
            ),
            FieldCustomWidget(
              hint: 'Password',
              controller: passwordController,
              prefixIcon: const Icon(Icons.key_rounded),
              obscureText: true,
              
            ),
            const SizedBox(
              height: 50,
            ),
            CustomButtonWidget(
              title: 'Masuk',
              onTap: () async {
                if(!(usernameController.text.trim()!=''&&passwordController.text.trim()!='')){
                  snackbarCustom(typeSnackbar: TypeSnackbar.info, message: "Harap mengiri username dan password terlebih dahulu");
                }
                await UserController().login(
                  username: usernameController.text,
                  password: passwordController.text,
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Lupa password ? ',
                    style: greyTextFont,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Ubah password ',
                    style: redTextFont,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
