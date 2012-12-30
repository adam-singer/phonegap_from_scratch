library Splashscreen;

import 'package:js/js.dart' as js;
import 'package:logging/logging.dart';

class Splashscreen {
  static final Splashscreen _singleton = new Splashscreen._internal();

  Logger _logger;
  js.Proxy _splashscreen;

  factory Splashscreen() {
    return _singleton;
  }

  Splashscreen._internal() {
    _logger = new Logger("Splashscreen");
    js.scoped(() {
      _splashscreen = js.context.navigator.splashscreen;
      js.retain(_splashscreen);
    });
  }

  void show() {
    _splashscreen.show();
  }

  void hide() {
    _splashscreen.hide();
  }
}
