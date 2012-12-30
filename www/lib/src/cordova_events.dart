library CordovaEvents;
import 'dart:html';
import 'package:js/js.dart' as js;
import 'package:logging/logging.dart';

/** The Events: Singleton */
class CordovaEvents {
  static final CordovaEvents _singleton = new CordovaEvents._internal();

  Logger _logger;

  factory CordovaEvents() {
    return _singleton;
  }

  CordovaEvents._internal() {
    _logger = new Logger("CordovaEvents");
    _registerHandlers();
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