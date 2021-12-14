import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

class UserApi {
  Router get router {
    final router = Router();

    router.get('/', (Request request) {
      return Response.ok("Hello User");
    });
    return router;
  }
}
