import 'dart:html' as html;
import 'package:js/js.dart' as js;
//import 'package:unittest/html_individual_config.dart';
import 'package:unittest/html_config.dart';
import 'package:unittest/unittest.dart';
import 'package:logging/logging.dart';
import 'lib/src/device.dart';
import 'lib/src/cordova_events.dart';
import 'lib/src/notification.dart';
import 'lib/src/splashscreen.dart';
import 'lib/src/connection.dart';
import 'lib/src/globalization.dart';

void main() {
  /**
   * Cordova.js will fire off 'deviceready' event once fully loaded.
   * listen for the event on js.context.document.
   *
   * This must be the first event wired up before creating Device.
   */
  html.document.on['deviceready'].add(deviceReady);

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

void deviceReady(html.Event event) {
  /**
   * This event has been posted, remove it so the
   * event handler in device can be tested.
   */
  html.document.on['deviceready'].remove(deviceReady);

  /**
   * Run the unit tests.
   */
  runTests();
}

void runTests() {
  Logger _logger = new Logger("runTests");
  //useHtmlIndividualConfiguration();
  useHtmlConfiguration();
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
      var asyncMethod = expectAsync1((html.Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new html.CustomEvent('$eventName', true, false, "custom event");
      var events = new CordovaEvents();
      events.onOnline.add(asyncMethod);
      html.document.on['$eventName'].dispatch(customEvent);
    });

    test('Device Event offline', () {
      var eventName = 'offline';
      var asyncMethod = expectAsync1((html.Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new html.CustomEvent('$eventName', true, false, "custom event");
      var events = new CordovaEvents();
      events.onOffline.add(asyncMethod);
      html.document.on['$eventName'].dispatch(customEvent);
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
      var asyncMethod = expectAsync1((html.Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new html.CustomEvent('$eventName', true, false, "custom event");
      var events = new CordovaEvents();
      events.onBackButton.add(asyncMethod);
      html.document.on['$eventName'].dispatch(customEvent);
    });

    test('Device Event batterycritical', () {
      var eventName = 'batterycritical';
      var asyncMethod = expectAsync1((html.Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new html.CustomEvent('$eventName', true, false, "custom event");
      var events = new CordovaEvents();
      events.onBatteryCritical.add(asyncMethod);
      html.document.on['$eventName'].dispatch(customEvent);
    });

    test('Device Event batterylow', () {
      var eventName = 'batterylow';
      var asyncMethod = expectAsync1((html.Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new html.CustomEvent('$eventName', true, false, "custom event");
      var events = new CordovaEvents();
      events.onBatteryLow.add(asyncMethod);
      html.document.on['$eventName'].dispatch(customEvent);
    });

    test('Device Event batterystatus', () {
      var eventName = 'batterystatus';
      var asyncMethod = expectAsync1((html.Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new html.CustomEvent('$eventName', true, false, "custom event");
      var events = new CordovaEvents();
      events.onBatteryStatus.add(asyncMethod);
      html.document.on['$eventName'].dispatch(customEvent);
    });

    test('Device Event menubutton', () {
      var eventName = 'menubutton';
      var asyncMethod = expectAsync1((html.Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new html.CustomEvent('$eventName', true, false, "custom event");
      var events = new CordovaEvents();
      events.onMenuButton.add(asyncMethod);
      html.document.on['$eventName'].dispatch(customEvent);
    });

    test('Device Event searchbutton', () {
      var eventName = 'searchbutton';
      var asyncMethod = expectAsync1((html.Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new html.CustomEvent('$eventName', true, false, "custom event");
      var events = new CordovaEvents();
      events.onSearchButton.add(asyncMethod);
      html.document.on['$eventName'].dispatch(customEvent);
    });

    test('Device Event startcallbutton', () {
      var eventName = 'startcallbutton';
      var asyncMethod = expectAsync1((html.Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new html.CustomEvent('$eventName', true, false, "custom event");
      var events = new CordovaEvents();
      events.onStartCallButton.add(asyncMethod);
      html.document.on['$eventName'].dispatch(customEvent);
    });

    test('Device Event endcallbutton', () {
      var eventName = 'endcallbutton';
      var asyncMethod = expectAsync1((html.Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new html.CustomEvent('$eventName', true, false, "custom event");
      var events = new CordovaEvents();
      events.onEndCallButton.add(asyncMethod);
      html.document.on['$eventName'].dispatch(customEvent);
    });

    test('Device Event volumedownbutton', () {
      var eventName = 'volumedownbutton';
      var asyncMethod = expectAsync1((html.Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new html.CustomEvent('$eventName', true, false, "custom event");
      var events = new CordovaEvents();
      events.onVolumeDownButton.add(asyncMethod);
      html.document.on['$eventName'].dispatch(customEvent);
    });

    test('Device Event volumeupbutton', () {
      var eventName = 'volumeupbutton';
      var asyncMethod = expectAsync1((html.Event event)=>expect(event.type, equals('$eventName')));
      var customEvent = new html.CustomEvent('$eventName', true, false, "custom event");
      var events = new CordovaEvents();
      events.onVolumeUpButton.add(asyncMethod);
      html.document.on['$eventName'].dispatch(customEvent);
    });

// iOS blocks this for some reason.
//    test('Notification alert', () {
//      var notification = new Notification();
//      notification.alert("hello")
//      .then((String _) {
//        print("_ = $_");
//        print("alertFuture.then completed");
//        //expect(_.isEmpty, isTrue);
//      });
//    });

//    test('Notification confirm', () {
//      var notification = new Notification();
//      var confirmFuture = notification.confirm("hello");
//      confirmFuture.then(expectAsync1((int index) {
//        print("confirmFuture.then completed, index = $index");
//        //expect(_.isEmpty, isTrue);
//      }));
//    });

    test('Connection type', () {
      var connection = new Connection();
      var type = connection.type;
      expect(type, equals("wifi"));
    });


    test('Globalization getPreferredLanguage', () {
      var globalization = new Globalization();
      var future = globalization.getPreferredLanguage();
      expect(future, completion(equals("en")));
      // NOTE: this extra call helped the unit tester complete.
      // Might be an error with unittest, cordova, or js-interop.
      globalization.getPreferredLanguage().then((r)=>_logger.fine("getPreferredLanguage = $r"));
    });

    test('Globalization getLocaleName', () {
      var globalization = new Globalization();
      var future = globalization.getLocaleName();
      expect(future, completion(equals("en_US")));
      // NOTE: this extra call helped the unit tester complete.
      // Might be an error with unittest, cordova, or js-interop.
      globalization.getLocaleName().then((r)=>_logger.fine("getLocaleName = $r"));
    });

// NOTE: Globalization implementation needs to be complete.
//    test('Globalization dateToString', () {
//      var globalization = new Globalization();
//      var d = new Date.now();
//      print(d.toString());
//      print(d.toLocal().toString());
//      print(d.toUtc().toString());
//      var future = globalization.dateToString(new Date.now());
//      future.handleException((e)=>_logger.fine("future.handleException = ${e.code} ${e.message}"));
//      expect(future, completion(equals("en_US")));
//      // NOTE: this extra call helped the unit tester complete.
//      // Might be an error with unittest, cordova, or js-interop.
//      globalization.dateToString(new Date.now()).then((r)=>_logger.fine("dateToString = $r"));
//    });

  });
}