import 'package:backend_demo/api/user_api.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class HomeController {
  // Define our getter for our handler
  Handler get handler {
    final app = Router();

    // main route
    app.get('/', (Request request) {
      return Response.ok('Hello World');
    });

    // Mount Other Controllers Here
    app.mount('/api/user', UserApi().router);

    // You can catch all verbs and use a URL-parameter with a regular expression
    // that matches everything to catch app.
    app.all('/<ignored|.*>', (Request request) {
      return Response.notFound('Page not found');
    });

    return app;
  }
}
