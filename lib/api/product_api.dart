import 'package:backend_demo/backend_demo.dart';

class ProductApi {
  Db db;
  ProductApi(
    this.db,
  );

  Router get router {
    DbCollection user = db.collection('users');
    final router = Router();

    //Get Api for listing user
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
