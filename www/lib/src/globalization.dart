library Globalization;

import 'package:js/js.dart' as js;
import 'package:logging/logging.dart';
class GlobalizationError {
  int code;
  String message;
  GlobalizationError(int this.code, String this.message);
}

class Globalization {
  static final Globalization _singleton = new Globalization._internal();

  Logger _logger;
  js.Proxy _globalization;

  factory Globalization() {
    return _singleton;
  }

  Globalization._internal() {
    _logger = new Logger("Globalization");
    js.scoped(() {
      _globalization = js.context.navigator.globalization;
      js.retain(_globalization);
    });
  }

  Future<String> getPreferredLanguage() {
    var completer = new Completer();
    js.scoped(() {
      void getPreferredLanguageSuccessCallback(var result) {
        var value = result.value;
        completer.complete(value);
      };

      void getPreferredLanguageErrorCallback() {
        completer.completeException("");
      };

      js.context.getPreferredLanguageSuccessCallback = new js.Callback.once(getPreferredLanguageSuccessCallback);
      js.context.getPreferredLanguageErrorCallback = new js.Callback.once(getPreferredLanguageErrorCallback);
      _globalization.getPreferredLanguage(js.context.getPreferredLanguageSuccessCallback, js.context.getPreferredLanguageErrorCallback);
    });
    return completer.future;
  }

  Future<String> getLocaleName() {
    var completer = new Completer();
    js.scoped(() {
      void getLocaleNameSuccessCallback(var result) {
        var value = result.value;
        completer.complete(value);
      };

      void getLocaleNameErrorCallback() {
        completer.completeException("");
      };

      js.context.getLocaleNameSuccessCallback = new js.Callback.once(getLocaleNameSuccessCallback);
      js.context.getLocaleNameErrorCallback = new js.Callback.once(getLocaleNameErrorCallback);
      _globalization.getLocaleName(js.context.getLocaleNameSuccessCallback, js.context.getLocaleNameErrorCallback);
    });
    return completer.future;
  }

  Future<String> dateToString(Date date, {formatLength:'short', selector:'date and time'}) {
    throw "Not implemented";
    // XXX: this needs more work on formatting issues. Better off using built in
    // Dart objects.
    var completer = new Completer();
    js.scoped(() {

      void dateToStringSuccessCallback(var result) {
        var value = result.value;
        var date = new Date.fromString(value);
        completer.complete(value);
      };

      void dateToStringErrorCallback(var error) {
        completer.completeException(new GlobalizationError(error.code, error.message));
      };

      var date_str = "${date.year}/${date.month}/${date.day}";
      var d = new js.Proxy(js.context.Date, date_str);
      var m = js.map({'formatLength': formatLength, 'selector': selector});
      js.context.dateToStringSuccessCallback = new js.Callback.once(dateToStringSuccessCallback);
      js.context.dateToStringErrorCallback = new js.Callback.once(dateToStringErrorCallback);
      _globalization.dateToString(d, js.context.dateToStringSuccessCallback, js.context.dateToStringErrorCallback, m);
    });
    return completer.future;
  }

  Future<Date> stringToDate() { throw "Not implemented"; }
  getDatePattern() { throw "Not implemented"; }
  getDateNames() { throw "Not implemented"; }
  isDayLightSavingsTime() { throw "Not implemented"; }
  getFirstDayOfWeek() { throw "Not implemented"; }
  numberToString() { throw "Not implemented"; }
  stringToNumber() { throw "Not implemented"; }
  getNumberPattern() { throw "Not implemented"; }
  getCurrencyPattern() { throw "Not implemented"; }
}
