library Notification;

import 'package:js/js.dart' as js;
import 'package:logging/logging.dart';

class Notification {
  static final Notification _singleton = new Notification._internal();

  Logger _logger;
  js.Proxy _notification;

  factory Notification() {
    return _singleton;
  }

  Notification._internal() {
    _logger = new Logger("Notification");
    js.scoped(() {
      _notification = js.context.navigator.notification;
      js.retain(_notification);
    });
  }

  Future<String> alert(String message, {String title: "Alert", String buttonName: "OK"}) {
    var completer = new Completer();
    js.scoped(() {
      void alertCallback() => completer.complete("");
      js.context.alertCallback = new js.Callback.once(alertCallback);
      _notification.alert(message, js.context.alertCallback, title, buttonName);
    });
    return completer.future;
  }

  Future<int> confirm(String message, {String title: "Confirm", String buttonLabels:  "OK,Cancel"}) {
    var completer = new Completer();
    js.scoped(() {
      void confirmCallback(int index) => completer.complete(index);
      js.context.confirmCallback = new js.Callback.once(confirmCallback);
      _notification.alert(message, js.context.confirmCallback, title, buttonLabels);
    });
    return completer.future;
  }

  void beep([int times = 1]) {
    _notification.beep(times);
  }

  void vibrate([int milliseconds = 2500]) {
    _notification.vibrate(milliseconds);
  }
}
