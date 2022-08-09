part of 'extensions.dart';

extension CurrencyExtension on int{
  String intToCurrency(){
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return currencyFormatter.format(this);
  }
}

extension CurrencyExtensionString on String{
  int toIntCurrency(){

    return int.parse(replaceAll("Rp", "").replaceAll(".", ""));
  }
}