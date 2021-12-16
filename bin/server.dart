import 'package:backend_demo/backend_demo.dart';

Future<void> main(List<String> arguments) async {
  final port = ENV.port;
  shelfRun(handler, defaultBindPort: int.parse(port));
}
