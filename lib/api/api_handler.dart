import 'package:backend_demo/api/api_auth.dart';
import 'package:backend_demo/api/product_api.dart';
import 'package:backend_demo/api/user_api.dart';
import 'package:backend_demo/backend_demo.dart';

class ApiHandler {
  // Define our getter for our handler
  Db db;

  ApiHandler(
    this.db,
  );

  Handler handler() {
    final router = Router().plus;

    // main route
    router.get('/', (Request request) {
      return Response.ok(jsonEncode({'key': 'Hello World'}));
    });
    // Api route
    router.get('/api', (Request request) {
      return Response.ok(jsonEncode({'key': 'Hello API'}));
    });

    // Mount Other Controllers Here
    router.mount('/api/auth', AuthApi(db).router);
    router.mount('/api/user', UserApi(db).router);
    router.mount('/api/product', ProductApi(db).router);

    // You can catch all verbs and use a URL-parameter with a regular expression
    // that matches everything to catch app.
    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('API not found');
    });

    return router;
  }
}
