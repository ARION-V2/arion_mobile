part of '../../pages.dart';

class AddKurirPage extends StatefulWidget {
  const AddKurirPage({
    Key? key,
    this.courier,
  }) : super(key: key);
  final User? courier;

  @override
  State<AddKurirPage> createState() => _AddKurirPageState();
}

class _AddKurirPageState extends State<AddKurirPage> {
  final courierController = Get.find<CourierController>();

  TextEditingController nameController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  DateTime? tanggalLahir;
  File? photo;
  String? urlPhoto;
  bool isChangePassword = true;

  @override
  void initState() {
    super.initState();
    if (widget.courier != null) {
      nameController.text = widget.courier!.name!;
      noHpController.text = widget.courier!.noHp!;
      usernameController.text = widget.courier!.username!;
      tanggalLahir = DateTime.parse(widget.courier!.dateOfBirth!);
      urlPhoto = widget.courier?.photo;
      isChangePassword = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      titleAppBar:
          Text((widget.courier != null) ? "Ubah data" : "Tambah Kurir"),
          actionsAppBar: [
        if (widget.courier != null)
          TextButton(
            onPressed: () async {
              courierController.deleteCourier(widget.courier!);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                "Hapus",
                style: whiteTextFontBold,
              ),
            ),
          )
      ],
      backgroundColorAppBar: mainColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              children: [
                CircleAvatarCustom(
                  url: urlPhoto,
                  imageFile: photo,
                  isPerson: true,
                  diameter: 85,
                ),
                TextButton(
                  onPressed: () async {
                    // controller.updatePhotoProfile(context);
                    photo = await getSingleImage(context);
                    setState(() {});
                  },
                  child: Text(
                    "Pilih Foto",
                    style: blueTextFontBold,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          FieldCustomWidget(
            title: "Nama Lengkap",
            hint: "Masukan nama",
            controller: nameController,
          ),
          const SizedBox(
            height: 15,
          ),
          FormCustomWidget(
            title: 'Tanggal Lahir',
            hint: "Pilih tanggal",
            content:
                (tanggalLahir != null) ? tanggalLahir!.dateAndTimeLahir : null,
            icon: const Icon(
              Icons.date_range,
              color: greyColor,
            ),
            onTap: () {
              selectedDate(context, onComfirm: (date) {
                setState(() {
                  tanggalLahir = date;
                });
              },
                  currentTIme: tanggalLahir ?? DateTime(2003, 1, 1),
                  maxTime: DateTime(2017, 12, 1));
            },
          ),
          const SizedBox(
            height: 15,
          ),
          FieldCustomWidget(
            title: "Nomor HP",
            hint: "Masukan nomor HP",
            controller: noHpController,
            typeKeyboard: TextInputType.number,
          ),
          const SizedBox(
            height: 20,
          ),
          FieldCustomWidget(
            title: "username",
            hint: "Masukan username",
            controller: usernameController,
            inputFormater: [
              FilteringTextInputFormatter.deny(
                RegExp(' '),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          (isChangePassword)
              ? FieldCustomWidget(
                  title: "Password",
                  hint: "Masukan password",
                  controller: passwordController,
                  obscureText: true,
                )
              : ListTile(
                  onTap: () {
                    setState(() {
                      isChangePassword = true;
                    });
                  },
                  title: Text(
                    "Ubah Password",
                    style: redTextFontTitleBold,
                  ),
                ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
      bottomNavigationBar: ButtonBottomDetailItemWidget(
        title1: "Simpan",
        onTap1: () async {
          if (!(nameController.text.trim() != "" &&
              tanggalLahir != null &&
              noHpController.text.trim() != '' &&
              usernameController.text.trim() != '')) {
            snackbarCustom(
                typeSnackbar: TypeSnackbar.error,
                message: "Harap untuk mengisi seluruh data terlebih dahulu");
          } else {
            if (widget.courier == null) {
              if (passwordController.text.trim() == '') {
                snackbarCustom(
                    typeSnackbar: TypeSnackbar.error,
                    message:
                        "Untuk menambahkan kurir password tidak boleh kosong");
                 return;
              }
             
            }
            User userRequest;
            if (widget.courier != null) {
              userRequest = widget.courier!.copyWith(
                name: nameController.text,
                dateOfBirth: tanggalLahir!.datePost,
                noHp: noHpController.text,
                username: usernameController.text,
              );
            } else {
              userRequest = User(
                name: nameController.text,
                dateOfBirth: tanggalLahir!.datePost,
                noHp: noHpController.text,
                username: usernameController.text,
              );
            }

            await courierController.addCourier(
              courier: userRequest,
              password: (passwordController.text.trim() != '')
                  ? passwordController.text
                  : null,
              file: photo,
            );
          }
        },
      ),
    );
  }
}
