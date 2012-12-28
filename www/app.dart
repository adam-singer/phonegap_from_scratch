import 'dart:html';
import 'package:js/js.dart' as js;
import 'package:unittest/html_individual_config.dart';
import 'package:unittest/unittest.dart';
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

    _registerHandlers();

    js.scoped(() {
      _device = js.context.device;
      js.retain(_device);
    });

  }

  void _registerHandlers() {
    _onDeviceReadyHandlers = new List<Function>();
    document.on['deviceready'].add(_onDeviceReady);

    _onPauseHandlers = new List<Function>();
    document.on['pause'].add(_onPause);

    _onResumeHandlers = new List<Function>();
    document.on['resume'].add(_onResume);

    _onOnlineHandlers = new List<Function>();
    document.on['online'].add(_onOnline);

    _onOfflineHandlers = new List<Function>();
    document.on['offline'].add(_onOffline);

    _onBackButtonHandlers = new List<Function>();
    document.on['backbutton'].add(_onBackButton);

    _onBatteryCriticalHandlers = new List<Function>();
    document.on['batterycritical'].add(_onBatteryCritical);

    _onBatteryLowHandlers = new List<Function>();
    document.on['batterylow'].add(_onBatteryLow);

    _onBatteryStatusHandlers = new List<Function>();
    document.on['batterystatus'].add(_onBatteryStatus);

    _onMenuButtonHandlers = new List<Function>();
    document.on['menubutton'].add(_onMenuButton);

    _onSearchButtonHandlers = new List<Function>();
    document.on['searchbutton'].add(_onSearchButton);

    _onStartCallButtonHandlers = new List<Function>();
    document.on['startcallbutton'].add(_onStartCallButton);

    _onEndCallButtonHandlers = new List<Function>();
    document.on['endcallbutton'].add(_onEndCallButton);

    _onVolumeDownButtonHandlers = new List<Function>();
    document.on['volumedownbutton'].add(_onVolumeDownButton);

    _onVolumeUpButtonHandlers = new List<Function>();
    document.on['volumeupbutton'].add(_onVolumeUpButton);
  }

  String get name => js.scoped(() => _device.name);
  String get cordova => js.scoped(() => _device.cordova);
  String get platform => js.scoped(() => _device.platform);
  String get uuid => js.scoped(() => _device.uuid);
  String get version => js.scoped(() => _device.version);

  // NOTE: this does not properly get fired from Device class
  // it needs to be hooked early in main or the event gets 'lost'
  List<Function> _onDeviceReadyHandlers;
  List<Function> get onDeviceReady => _onDeviceReadyHandlers;
  void _onDeviceReady(Event event) => _onDeviceReadyHandlers.forEach((handler)=>handler(event));

  List<Function> _onPauseHandlers;
  List<Function> get onPause => _onPauseHandlers;
  void _onPause(Event event) => _onPauseHandlers.forEach((handler)=>handler(event));

  List<Function> _onResumeHandlers;
  List<Function> get onResume => _onResumeHandlers;
  void _onResume(Event event) => _onResumeHandlers.forEach((handler)=>handler(event));

  List<Function> _onOnlineHandlers;
  List<Function> get onOnline => _onOnlineHandlers;
  void _onOnline(Event event) => _onOnlineHandlers.forEach((handler)=>handler(event));

  List<Function> _onOfflineHandlers;
  List<Function> get onOffline => _onOfflineHandlers;
  void _onOffline(Event event) => _onOfflineHandlers.forEach((handler)=>handler(event));

  List<Function> _onBackButtonHandlers;
  List<Function> get onBackButton => _onBackButtonHandlers;
  void _onBackButton(Event event) => _onBackButtonHandlers.forEach((handler)=>handler(event));

  List<Function> _onBatteryCriticalHandlers;
  List<Function> get onBatteryCritical => _onBatteryCriticalHandlers;
  void _onBatteryCritical(Event event) => _onBatteryCriticalHandlers.forEach((handler)=>handler(event));

  List<Function> _onBatteryLowHandlers;
  List<Function> get onBatteryLow => _onBatteryLowHandlers;
  void _onBatteryLow(Event event) => _onBatteryLowHandlers.forEach((handler)=>handler(event));

  List<Function> _onBatteryStatusHandlers;
  List<Function> get onBatteryStatus => _onBatteryStatusHandlers;
  void _onBatteryStatus(Event event) => _onBatteryStatusHandlers.forEach((handler)=>handler(event));

  List<Function> _onMenuButtonHandlers;
  List<Function> get onMenuButton => _onMenuButtonHandlers;
  void _onMenuButton(Event event) => _onMenuButtonHandlers.forEach((handler)=>handler(event));

  List<Function> _onSearchButtonHandlers;
  List<Function> get onSearchButton => _onSearchButtonHandlers;
  void _onSearchButton(Event event) => _onSearchButtonHandlers.forEach((handler)=>handler(event));

  List<Function> _onStartCallButtonHandlers;
  List<Function> get onStartCallButton => _onStartCallButtonHandlers;
  void _onStartCallButton(Event event) => _onStartCallButtonHandlers.forEach((handler)=>handler(event));

  List<Function> _onEndCallButtonHandlers;
  List<Function> get onEndCallButton => _onEndCallButtonHandlers;
  void _onEndCallButton(Event event) => _onEndCallButtonHandlers.forEach((handler)=>handler(event));

  List<Function> _onVolumeDownButtonHandlers;
  List<Function> get onVolumeDownButton => _onVolumeDownButtonHandlers;
  void _onVolumeDownButton(Event event) => _onVolumeDownButtonHandlers.forEach((handler)=>handler(event));

  List<Function> _onVolumeUpButtonHandlers;
  List<Function> get onVolumeUpButton => _onVolumeUpButtonHandlers;
  void _onVolumeUpButton(Event event) => _onVolumeUpButtonHandlers.forEach((handler)=>handler(event));
}

void main() {
  /**
   * Cordova.js will fire off 'deviceready' event once fully loaded.
   * listen for the event on js.context.document.
   *
   * This must be the first event wired up before creating Device.
   */
  document.on['deviceready'].add(deviceReady);

  /**
   * Configure logging for the application
   */
  configureLogging();

  /**
   * For now online/offline event when the device starts needs to
   * hooked before the event fires. It can be caught later after
   * startup. Its possible to remove the handler and add a new one
   * once the application state is ready.
   */
  //document.on['online'].add(onlineHandler);
  //document.on['offline'].add(offlineHandler);
  //NOTE: might need to hook these early like online/offline
  //document.on['batterycritical'].add((e)=>print("batterycritical = $e"));
  //document.on['batterylow'].add((e)=>print("batterylow = $e"));
  //document.on['batterystatus'].add((e)=>print("batterystatus = $e"));
}

void configureLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.on.record.add((LogRecord r) {
    // Print to console.log when compiled to javascript.
    print("${r.loggerName}:${r.level.name}:${r.sequenceNumber}:\n${r.message.toString()}");
  });
}

void deviceReady(Event event) {
  /**
   * This event has been posted, remove it so the
   * event handler in device can be tested.
   */
  document.on['deviceready'].remove(deviceReady);

  /**
   * Run the unit tests.
   */
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

    test('Device Event online', () {
      var eventName = 'online';
      var asyncMethod = expectAsync1((Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new CustomEvent('$eventName', true, false, "custom event");
      var device = new Device();
      device.onOnline.add(asyncMethod);
      document.on['$eventName'].dispatch(customEvent);
    });

    test('Device Event offline', () {
      var eventName = 'offline';
      var asyncMethod = expectAsync1((Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new CustomEvent('$eventName', true, false, "custom event");
      var device = new Device();
      device.onOffline.add(asyncMethod);
      document.on['$eventName'].dispatch(customEvent);
    });

// NOTE: this event cannot be unit tested since it will bubble up to cordova.
// Functional tests possble.
//    test('Device Event deviceready', () {
//      var eventName = 'deviceready';
//      var asyncMethod = expectAsync1((Event event)=>expect(event.type, equals('$eventName')));
//      var customEvent = new CustomEvent('$eventName', true, false, "custom event");
//      var device = new Device();
//      device.onDeviceReady.add(asyncMethod);
//      document.on['$eventName'].dispatch(customEvent);
//    });

// NOTE: this event cannot be unit tested since it will bubble up to cordova.
// Functional tests possble.
//    test('Device Event pause', () {
//      var eventName = 'pause';
//      var asyncMethod = expectAsync1((Event event)=>expect(event.type, equals('$eventName')));
//      var customEvent = new CustomEvent('$eventName', true, false, "custom event");
//      var device = new Device();
//      device.onPause.add(asyncMethod);
//      document.on['$eventName'].dispatch(customEvent);
//    });

// NOTE: this event cannot be unit tested since it will bubble up to cordova.
// Functional tests possble.
//    test('Device Event resume', () {
//      var eventName = 'resume';
//      var asyncMethod = expectAsync1((Event event)=>expect(event.type, equals('$eventName')));
//      var customEvent = new CustomEvent('$eventName', true, false, "custom event");
//      var device = new Device();
//      device.onResume.add(asyncMethod);
//      document.on['$eventName'].dispatch(customEvent);
//    });

    test('Device Event backbutton', () {
      var eventName = 'backbutton';
      var asyncMethod = expectAsync1((Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new CustomEvent('$eventName', true, false, "custom event");
      var device = new Device();
      device.onBackButton.add(asyncMethod);
      document.on['$eventName'].dispatch(customEvent);
    });

    test('Device Event batterycritical', () {
      var eventName = 'batterycritical';
      var asyncMethod = expectAsync1((Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new CustomEvent('$eventName', true, false, "custom event");
      var device = new Device();
      device.onBatteryCritical.add(asyncMethod);
      document.on['$eventName'].dispatch(customEvent);
    });

    test('Device Event batterylow', () {
      var eventName = 'batterylow';
      var asyncMethod = expectAsync1((Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new CustomEvent('$eventName', true, false, "custom event");
      var device = new Device();
      device.onBatteryLow.add(asyncMethod);
      document.on['$eventName'].dispatch(customEvent);
    });

    test('Device Event batterystatus', () {
      var eventName = 'batterystatus';
      var asyncMethod = expectAsync1((Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new CustomEvent('$eventName', true, false, "custom event");
      var device = new Device();
      device.onBatteryStatus.add(asyncMethod);
      document.on['$eventName'].dispatch(customEvent);
    });

    test('Device Event menubutton', () {
      var eventName = 'menubutton';
      var asyncMethod = expectAsync1((Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new CustomEvent('$eventName', true, false, "custom event");
      var device = new Device();
      device.onMenuButton.add(asyncMethod);
      document.on['$eventName'].dispatch(customEvent);
    });

    test('Device Event searchbutton', () {
      var eventName = 'searchbutton';
      var asyncMethod = expectAsync1((Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new CustomEvent('$eventName', true, false, "custom event");
      var device = new Device();
      device.onSearchButton.add(asyncMethod);
      document.on['$eventName'].dispatch(customEvent);
    });

    test('Device Event startcallbutton', () {
      var eventName = 'startcallbutton';
      var asyncMethod = expectAsync1((Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new CustomEvent('$eventName', true, false, "custom event");
      var device = new Device();
      device.onStartCallButton.add(asyncMethod);
      document.on['$eventName'].dispatch(customEvent);
    });

    test('Device Event endcallbutton', () {
      var eventName = 'endcallbutton';
      var asyncMethod = expectAsync1((Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new CustomEvent('$eventName', true, false, "custom event");
      var device = new Device();
      device.onEndCallButton.add(asyncMethod);
      document.on['$eventName'].dispatch(customEvent);
    });

    test('Device Event volumedownbutton', () {
      var eventName = 'volumedownbutton';
      var asyncMethod = expectAsync1((Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new CustomEvent('$eventName', true, false, "custom event");
      var device = new Device();
      device.onVolumeDownButton.add(asyncMethod);
      document.on['$eventName'].dispatch(customEvent);
    });

    test('Device Event volumeupbutton', () {
      var eventName = 'volumeupbutton';
      var asyncMethod = expectAsync1((Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new CustomEvent('$eventName', true, false, "custom event");
      var device = new Device();
      device.onVolumeUpButton.add(asyncMethod);
      document.on['$eventName'].dispatch(customEvent);
    });
  });
}