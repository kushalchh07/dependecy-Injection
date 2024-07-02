import 'dart:developer';

class AppService {
  AppService() {
    log("Appservice  instance is being created");
  }
  String getDate() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return date.toString();
  }
}
