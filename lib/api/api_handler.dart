import 'package:backend_demo/api/user_api.dart';
import 'package:backend_demo/backend_demo.dart';

class ApiHandler {
  // Define our getter for our handler
  Db db;

  ApiHandler({
    required this.db,
  });

  Router get handler {
    final router = Router();

    // main route
    router.get('/', (Request request) {
      return Response.ok('Hello World123456');
    });

    // Mount Other Controllers Here
    router.mount('/api/user', UserApi(db).router);

    // You can catch all verbs and use a URL-parameter with a regular expression
    // that matches everything to catch app.
    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('Page not found');
    });

    return router;
  }
}
