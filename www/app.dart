import 'dart:html';
import 'package:js/js.dart' as js;
import 'package:unittest/html_individual_config.dart';
import 'package:unittest/unittest.dart';

/** The device: Singleton */
class Device {
  static final Device _singleton = new Device._internal();
  js.Proxy _device;

  factory Device() {
    return _singleton;
  }

  Device._internal() {
    js.scoped(() {
      _device = js.context.device;
      js.retain(_device);
    });
  }

  String get name => js.scoped(() => _device.name);
  String get cordova => js.scoped(() => _device.cordova);
  String get platform => js.scoped(() => _device.platform);
  String get uuid => js.scoped(() => _device.uuid);
  String get version => js.scoped(() => _device.version);
}

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
  runTests();
}

void runTests() {
  useHtmlIndividualConfiguration();
  group('cordova', () {
    test('Device', () {
      var device = new Device();
      expect(device.name, equals("iPhone Simulator"));
      expect(device.cordova, equals("2.2.0"));
      expect(device.platform, equals("iPhone Simulator"));
      expect(device.uuid, equals("1D9F5E5B-B4FB-4FDB-8A1E-62434421B068"));
      expect(device.version, equals("6.0"));
    });
  });
}