import 'package:schedule_service/schedule_service.dart';

Middleware handlerAuth() {
  return (Handler innerHandler) {
    return (Request request) async {
      final params = request.url.queryParameters;
      final token = params['accessToken'];
      if (token == null) {
        final qRequestUpdate = request.change(context: {
          'role': null,
        });
        return innerHandler(qRequestUpdate);
      }
      try {
        final jwt =
            JWT.verify(token, SecretKey(secretKey()), issuer: 'degree_auth');
        final id = int.parse(jwt.subject!);
        final role = (id == 1) ? 'admin' : 'user';
        final qRequestUpdate = request.change(context: {
          'role': role,
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
