/* import 'package:mysql1/mysql1.dart';

var connectionSettings = ConnectionSettings(
  host: 'localhost',
  port: 8081,
  user: 'root',
  password: 'root',
  db: 'dart_api',
);
 */
import 'package:envify/envify.dart';

part 'config.g.dart';

@Envify()
abstract class ENV {
  static const secretKey = _ENV.secretKey;
}
