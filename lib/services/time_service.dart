class TimeService {
  // Fungsi untuk mengonversi waktu ke zona waktu yang diinginkan
  DateTime convertTimeToTimezone(DateTime time, String timezone) {
    if (timezone == 'WIB') {
      return time.add(Duration(hours: 7));
    } else if (timezone == 'WITA') {
      return time.add(Duration(hours: 8));
    } else if (timezone == 'WIT') {
      return time.add(Duration(hours: 9));
    } else {
      return time; // Default UTC
    }
  }
}
