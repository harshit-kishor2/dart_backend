import 'package:backend_demo/backend_demo.dart';

Future<void> main(List<String> arguments) async {
  final port = ENV.port;

  //Create connection for mongo db
  final db = await connection();

  shelfRun(ApiHandler(db).handler, defaultBindPort: int.parse(port));
}
