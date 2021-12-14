import 'dart:async';
import 'package:backend_demo/backend_demo.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

Future<void> main(List<String> arguments) async {
  // const secret = "This is secret key";
  final port = 4000;
  dynamic address = 'localhost';

  //! Instantiate Home Controller
  final home = HomeController();

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(handleCors())
      //.addMiddleware(handleAuth(secret))
      .addHandler(home.handler);

  await serve(handler, address, port);
  print('Server on: http://localhost:$port');
}
