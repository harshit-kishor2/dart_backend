import 'package:backend_demo/backend_demo.dart';

class UserApi {
  Db db;
  UserApi(
    this.db,
  );

  Router get router {
    DbCollection user = db.collection('users');
    final router = Router();
    router.get('/', (Request request) async {
      final users = [];
      await user.find().forEach((element) {
        users.add(element);
      });
      return Response.ok(jsonEncode(users));
    });
    return router;
  }
}
