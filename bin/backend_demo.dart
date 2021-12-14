import 'package:backend_demo/backend_demo.dart';

Future<void> main(List<String> arguments) async {
  withHotreload(() => createServer());
}

Future<HttpServer> createServer() async {
  final port = ENV.port;
  dynamic address = 'localhost';

  //For connecting database
  final mongoUrl = ENV.mongoUrl;
  final db = await Db.create(mongoUrl);
  await db.open();
  if (db.isConnected) {
    print('Connected to  database');
  } else {
    print('Not Connected to our database');
  }

  //! Instantiate API Handler
  final api = ApiHandler(db: db);

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(handleCors())
      //.addMiddleware(handleAuth(secret))
      .addHandler(api.handler);

  print('Server on: http://localhost:$port');
  return serve(handler, address, int.parse(port));
}
