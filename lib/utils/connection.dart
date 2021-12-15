import 'package:backend_demo/backend_demo.dart';

Future<Db> connection() async {
  //For connecting database
  final mongoUrl = ENV.mongoUrl;
  final db = await Db.create(mongoUrl);
  await db.open();
  if (db.isConnected) {
    print('Connected to  database');
  } else {
    print('Not Connected to our database');
  }
  return db;
}
