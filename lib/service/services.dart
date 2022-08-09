// String baseUrl = "http://192.168.100.29:8080";
String googleMapsKey = "AIzaSyCXEykmj3RsEDFNBrLCmA-lmxKCWqT-zCI";


// String baseUrl = "http://10.0.2.2:8000";
String baseUrl ="http://10.0.146.157:8080";



String baseUrlApi = "$baseUrl/api";

int maxResponseTime = 60;

String baseUrlStorage = "$baseUrl/storage/";

String urlLogin= "$baseUrlApi/auth/login";
String urlRegister= "$baseUrlApi/auth/register";
String urlgetUser= "$baseUrlApi/user/getMyUser";

String urlLogout = "$baseUrlApi/auth/logout";
String urlUpdateProfile = "$baseUrlApi/user/update";
String urlChangePassword = "$baseUrlApi/auth/changePassword";
String urlUpdatePhotoProfile = "$baseUrlApi/user/updatePhotoProfile";
String urlUsernameCheck = "$baseUrlApi/user/checkUsername";


///Partner
String urlgetAllPartner= "$baseUrlApi/partner/all";
String urlAddPartner= "$baseUrlApi/partner/update";
String urlDeletePartner= "$baseUrlApi/partner/delete";


///Courier
String urlGetAllCourier= "$baseUrlApi/courier/all";
String urlUpdateCourier= "$baseUrlApi/courier/update";
String urlDeleteCourier= "$baseUrlApi/courier/delete";

///Product
String urlGetAllProduct= "$baseUrlApi/product/all";
String urlUpdateProduct= "$baseUrlApi/product/update";
String urlDeleteProduct= "$baseUrlApi/product/delete";


///Delivery
String urlGetAllDelivery= "$baseUrlApi/delivery/all";
String urlUpdateDelivery= "$baseUrlApi/delivery/update";
String urlDeleteDelivery= "$baseUrlApi/delivery/delete";
String urlGetMappingDelivery= "$baseUrlApi/checkMapping/all";

