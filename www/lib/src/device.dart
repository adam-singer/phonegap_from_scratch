library Device;

import 'package:js/js.dart' as js;
import 'package:logging/logging.dart';

/** The device: Singleton */
class Device {
  static final Device _singleton = new Device._internal();

  Logger _logger;
  js.Proxy _device;

  factory Device() {
    return _singleton;
  }

  Device._internal() {
    _logger = new Logger("Device");
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