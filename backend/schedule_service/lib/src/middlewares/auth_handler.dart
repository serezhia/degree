import 'package:schedule_service/schedule_service.dart';

Middleware handlerAuth() {
  return (Handler innerHandler) {
    return (Request request) async {
      final params = request.url.queryParameters;
      final token = params['access_token'];
      if (token == null) {
        final qRequestUpdate = request.change(context: {
          'role': null,
        });
        return innerHandler(qRequestUpdate);
      }
      try {
        final jwt =
            JWT.verify(token, SecretKey(secretKey()), issuer: 'degree_auth');

        final role = jwt.payload['role'].toString().split('.').last;
        final qRequestUpdate = request.change(context: {
          'role': role,
          'access_token': token,
        });

        return innerHandler(qRequestUpdate);
      } catch (e) {
        final qRequestUpdate = request.change(context: {
          'role': null,
        });
        return innerHandler(qRequestUpdate);
      }
    };
  };
}

Middleware checkAutorization() {
  return createMiddleware(requestHandler: (Request req) {
    if (req.context['role'] == null) {
      return Response.unauthorized('Invalid auth');
    }
    return null;
  });
}
