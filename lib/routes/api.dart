import 'package:backend_demo/routes/auth_api.dart';
import 'package:backend_demo/backend_demo.dart';

Future<Handler> handler() async {
  //! Connect to mongodb
  Db db = await connection();

  final router = Router().plus;

  //! Apply Middleware
  router.use(logRequests());

  //! Define routes

  router.get('/', (Request request) {
    return Response.ok(jsonEncode({'key': 'Hello World'}));
  });

  router.get('/api', (Request request) {
    return Response.ok(jsonEncode({'key': 'Inside API'}));
  });

  //! Mount Other Routes Here
  router.mount('/api/auth', authRouter(db));
  // router.mount('/api/user', UserApi(db).router);
  // router.mount('/api/product', ProductApi(db).router);

  // You can catch all verbs and use a URL-parameter with a regular expression
  // that matches everything to catch app.
  router.all('/<ignored|.*>', (Request request) {
    return Response.notFound('API not found');
  });

  return router;
}
