import 'package:backend_demo/backend_demo.dart';

Middleware handleAuth(String secret) {
  return (Handler innerHandler) {
    return (Request request) async {
      final authHeader = request.headers['authorization'];
      var token = '', jwt = '';

      if (authHeader != null && authHeader.startsWith('Bearer ')) {
        token = authHeader.substring(7);
        jwt = verifyJwt(token, secret);
      }

      final updatedRequest = request.change(context: {
        'authDetails': jwt,
      });
      return await innerHandler(updatedRequest);
    };
  };
}

Middleware handleCors() {
  const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
    'Access-Control-Allow-Headers': 'Origin, Content-Type',
  };

  return createMiddleware(
    requestHandler: (Request request) {
      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: corsHeaders);
      }
      return null;
    },
    responseHandler: (Response response) {
      return response.change(headers: corsHeaders);
    },
  );
}
