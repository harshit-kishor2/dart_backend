import 'package:backend_demo/backend_demo.dart';
import 'package:backend_demo/controller/auth_controller.dart';

RouterPlus authRouter(db) {
  final router = Router().plus;

  // Apply Middleware
  router.use(logRequests());

  //Get Api
  router.get('/', (Request request) async {
    return Response.ok(jsonEncode({'key': 'Inside AuthApi'}));
  });
// ===============================================================
//! POST Api for Register user
  router.post('/register', (Request request) {
    return registerController(request, db);
  });

  //===========================================================
  //! POST Api for Login user
  router.post('/login', (Request request) {
    return loginController(request, db);
  });

  //===========================================================
  return router;
}
