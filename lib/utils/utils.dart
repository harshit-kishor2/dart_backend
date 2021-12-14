import 'package:backend_demo/backend_demo.dart';

String generateSalt([int length = 32]) {
  final rand = Random.secure();
  final saltBytes = List<int>.generate(length, (_) => rand.nextInt(256));
  return base64.encode(saltBytes);
}

String hashPassword(String password, String salt) {
  final codec = Utf8Codec();
  final key = codec.encode(password);
  final saltBytes = codec.encode(salt);
  final hmac = Hmac(sha256, key);
  final digest = hmac.convert(saltBytes);
  return digest.toString();
}

String generateJwt(
  String subject,
  String issuer,
  String secret, {
  required String jwtId,
  Duration expiry = const Duration(seconds: 30),
}) {
  final jwt = JWT(
    {
      'iat': DateTime.now().millisecondsSinceEpoch,
    },
    subject: subject,
    issuer: issuer,
    jwtId: jwtId,
  );
  return jwt.sign(SecretKey(secret), expiresIn: expiry);
}

dynamic verifyJwt(String token, String secret) {
  try {
    final jwt = JWT.verify(token, SecretKey(secret));
    return jwt;
  } on JWTExpiredError {
    // TODO Handle error
  } on JWTError catch (err) {
    // TODO Handle error
  }
}
