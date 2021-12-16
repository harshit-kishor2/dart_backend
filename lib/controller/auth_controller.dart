import 'package:backend_demo/backend_demo.dart';

registerController(request, db) async {
  DbCollection userTable = db.collection('users');
  final userInfo = jsonDecode(await request.readAsString());
  final email = userInfo['email'];
  final password = userInfo['password'];
  final username = userInfo['username'];

  //Check fields are not null or empty
  if (email == null ||
      email.trim() == '' ||
      password == null ||
      password.trim() == '' ||
      username == null ||
      username.trim() == '') {
    return response(
        code: HttpStatus.lengthRequired,
        message: 'Please fill all required fields.');
  }
  // Ensure user is unique
  final userData = await userTable.findOne(where.eq('email', email));
  if (userData != null) {
    return response(
      code: HttpStatus.conflict,
      message: 'User already exists.',
    );
  }

  //Create user
  final salt = generateSalt();
  final hashedPassword = hashPassword(password, salt);
  var savedUser = {
    'email': email,
    "username": username,
    'password': hashedPassword,
    'salt': salt,
    'createdAt': DateTime.now().toUtc().toString(),
    'updatedAt': DateTime.now().toUtc().toString(),
    'authToken': '',
    'resetPasswordToken': ''
  };
  await userTable.insertOne(savedUser);
  savedUser.remove('password');
  return response(
      code: HttpStatus.ok,
      message: 'User Registerd successfully.',
      data: savedUser);
}

loginController(request, db) async {
  DbCollection userTable = db.collection('users');
  final userInfo = jsonDecode(await request.readAsString());
  final email = userInfo['email'];
  final password = userInfo['password'];

  //Check fields are not null or empty
  if (email == null ||
      email.trim() == '' ||
      password == null ||
      password.trim() == '') {
    return response(
        code: HttpStatus.lengthRequired,
        message: 'Please provide email and password.');
  }

  //Check user email avilablity
  final user = await userTable.findOne(where.eq('email', email));
  if (user == null) {
    return response(
        code: HttpStatus.forbidden, message: 'Incorrect email and/or password');
  }

  //Check password correct or not
  final hashedPassword = hashPassword(password, user['salt']);
  if (hashedPassword != user['password']) {
    return response(
        code: HttpStatus.forbidden, message: 'Incorrect email and/or password');
  }
  // Generate JWT and send with response
  final userId = (user['_id'] as ObjectId).toHexString();
  try {
    final tokenId = Uuid().v4();
    final secret = ENV.secretKey;
    final token = generateJwt(userId, 'http://localhost', secret,
        jwtId: tokenId, expiry: Duration(days: 2));

    await userTable.updateOne(
        where.eq('email', email),
        ModifierBuilder()
            .set('authToken', token)
            .set('lastLogin', DateTime.now().toUtc().toString())
            .set('updatedAt', DateTime.now().toUtc().toString()));

    final user = await userTable.findOne(where.eq('email', email));
    user!.remove('password');
    return response(
        code: HttpStatus.ok,
        message: 'User Login successfully.',
        data: {'userDetails': user, 'token': token});
  } catch (e) {
    return response(
        code: HttpStatus.internalServerError,
        message: 'Some Server Error.',
        data: null);
  }
}
