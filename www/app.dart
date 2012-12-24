import 'dart:html';
import 'package:js/js.dart' as js;

void main() {
  /**
   * Cordova.js will fire off 'deviceready' event once fully loaded.
   * listen for the event on js.context.document
   */
  document.on['deviceready'].add(deviceReady);
}

void deviceReady(Event event) {
  print("event = ${event.type}");
  print("device is ready");
}