import 'package:envify/envify.dart';

part 'config.g.dart';

@Envify()
abstract class ENV {
  static const secretKey = _ENV.secretKey;
  static const port = _ENV.port;
  static const mongoUrl = _ENV.mongoUrl;
}
