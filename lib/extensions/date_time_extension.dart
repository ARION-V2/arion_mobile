part of 'extensions.dart';

extension DateTimeExtension on DateTime {
  String get dateAndTime => "$shortdayName, $day $shortmounthName $year  ("
      "${(hour < 10) ? 0 : ""}"
      "$hour:"
      "${(minute <= 10) ? 0 : ""}"
      "$minute)";
  String get dateAndTimeNoMinute =>
      "$shortdayName, $day $shortmounthName $year";
  String get dateAndTimeNoDayName => "$day $shortmounthName $year";

  String get dayAndMont => "$shortmounthName $year";

  String get dateAndTimeLahir => "$shortdayName, $day $shortmounthName $year ";
  String get dateAndTimeNumber => "$day-$month-$year";
  String get clockTime => "${(hour < 10) ? 0 : ""}"
      "$hour : "
      "${(minute <= 10) ? 0 : ""}"
      "$minute";
  String get datePost =>
      "$year-${(month < 10) ? "0" + month.toString() : month}-${(day < 10) ? "0" + day.toString() : day}";
  String get getMonthPost =>
      "$year-${(month < 10) ? "0" + month.toString() : month}";

  String get timeInChat {
    return (DateTime(year, month, day) ==
            DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day))
        ? clockTime
        : "$dateAndTimeNumber ($clockTime)";
  }

  String get shortmounthName {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return "Mei";
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return 'Minggu';
    }
  }

  String get shortdayName {
    switch (weekday) {
      case 1:
        return 'Senin';
      case 2:
        return 'Selasa';
      case 3:
        return 'Rabu';
      case 4:
        return 'Kamis';
      case 5:
        return "Jum'at";
      case 6:
        return 'Sabtu';
      default:
        return 'Minggu';
    }
  }
}

extension TimeExtensionTimeOfDay on TimeOfDay {
  String get timeToString => "${(hour < 10) ? 0 : ""}"
      "$hour : "
      "${(minute <= 10) ? 0 : ""}"
      "$minute";}

extension StringToDateTime on String {
  DateTime get stringToDateTime {
    List<String> result = split('-').toList();
    return DateTime(
        int.parse(result[2]), int.parse(result[1]), int.parse(result[0]));
  }

  TimeOfDay stringToTime() => TimeOfDay(
      hour: int.parse(split(':')[0]),
      minute: int.parse(split(':')[1]),
    );
}



extension IntToDateTime on int {
  String get shortmounthName {
    switch (this) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return "Mei";
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return 'Minggu';
    }
  }
}
