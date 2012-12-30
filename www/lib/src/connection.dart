library Connection;

import 'package:js/js.dart' as js;
import 'package:logging/logging.dart';

class Connection {
  static final Connection _singleton = new Connection._internal();

  Logger _logger;
  js.Proxy _connection;

  factory Connection() {
    return _singleton;
  }

  Connection._internal() {
    _logger = new Logger("Connection");
    js.scoped(() {
      _connection = js.context.navigator.connection;
      js.retain(_connection);
    });
  }

  String get type => js.scoped(() => _connection.type);
}
