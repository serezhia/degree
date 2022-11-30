import 'package:auth_service/auth_service.dart';

class UsersRoute {
  final UserRepository userRepository;
  final TokenRepository tokenRepository;

  UsersRoute(this.userRepository, this.tokenRepository);

  Router get router {
    final router = Router();

    // Create user
    router.post('/', (Request req) async {
      final params = req.url.queryParameters;
      final firstName = params['firstName'];
      final secondName = params['secondName'];
      final middleName = params['middleName'];
      final roleNotEnum = params['role'];

      if (firstName == null || secondName == null || roleNotEnum == null) {
        return Response.badRequest(
            body: 'firstName, secondName and role are required');
      }
      final Role role;
      try {
        role = Role.values
            .firstWhere((element) => element.toString() == 'Role.$roleNotEnum');
      } catch (_) {
        return Response.badRequest(body: 'Role is not valid');
      }
      String registerCode;
      do {
        registerCode = generateRegisterCode();
      } while (!await userRepository.existsUserByRegisterCode(registerCode));

      final User user;
      try {
        user = await userRepository.insertUser(
            firstName, secondName, middleName, registerCode, role);
      } on Exception catch (e) {
        return Response.internalServerError(body: e.toString());
      }
      return Response.ok(jsonEncode({
        'id': user.id,
        'firstName': user.firstName,
        'secondName': user.secondName,
        'middleName': user.middleName,
        'role': user.role.toString().split('.').last,
        'registerCode': user.registerCode,
      }));
    });

    // Is registerCode exists
    router.get('/codeIsAlive/<registerCode>',
        (Request req, String registerCode) async {
      try {
        await userRepository.getUserByRegisterCode(registerCode);
        return Response.ok('User exists');
      } catch (e) {
        return Response.internalServerError(body: 'User not found');
      }
    });

    // Update User
    router.post('/<registerCode>', (Request req, String registerCode) async {
      final params = req.url.queryParameters;
      final password = params['password'];
      final username = params['username'];

      if (password == null || username == null) {
        return Response.badRequest(body: 'password and username are required');
      }

      final User user;
      try {
        user = await userRepository.getUserByRegisterCode(registerCode);
      } catch (e) {
        return Response.internalServerError(body: 'User not found');
      }

      final salt = createSalt();
      final hashedPassword = createHashedPassword(password, salt);

      final User userUpdated;
      try {
        userUpdated = await userRepository.updateUser(User(
          id: user.id,
          firstName: user.firstName,
          secondName: user.secondName,
          middleName: user.middleName,
          username: username,
          role: user.role,
          registerCode: registerCode,
          hashedPassword: hashedPassword,
          salt: salt,
        ));
      } on Exception catch (e) {
        return Response.internalServerError(body: e.toString());
      }
      return Response.ok(jsonEncode({
        'id': userUpdated.id,
        'firstName': userUpdated.firstName,
        'secondName': userUpdated.secondName,
        'middleName': userUpdated.middleName,
        'username': userUpdated.username,
        'hashedPassword': userUpdated.hashedPassword,
        'salt': userUpdated.salt,
        'role': user.role.toString().split('.').last,
        'registerCode': null,
      }));
    });

    // Get user
    router.get('/<id>', (Request req, String id) async {
      final params = req.url.queryParameters;
      final accessToken = params['access_token'];
      final JWT jwt;

      if (accessToken == null) {
        return Response.badRequest(body: 'access_token is required');
      }

      try {
        jwt = JWT.verify(accessToken, SecretKey(secretKey()),
            issuer: 'degree_auth');
      } catch (e) {
        return Response.unauthorized('Invalid access_token');
      }

      final role = jwt.payload['role'].toString().split('.').last;

      if (role == 'admin' || role == 'teacher' || role == 'student') {
        final int userId = int.parse(id);
        final User user;
        try {
          user = await userRepository.getUser(userId);
        } catch (e) {
          return Response.internalServerError(body: 'User not found');
        }
        return Response.ok(jsonEncode({
          'id': user.id,
          'firstName': user.firstName,
          'secondName': user.secondName,
          'middleName': user.middleName,
          'username': user.username,
          'hashedPassword': user.hashedPassword,
          'salt': user.salt,
          'role': user.role.toString().split('.').last,
          'registerCode': user.registerCode,
        }));
      }
      return Response.unauthorized('Invalid access');
    });

    // get all users

    router.get('/', (Request req) async {
      final params = req.url.queryParameters;
      final accessToken = params['access_token'];

      if (accessToken == null) {
        return Response.badRequest(body: 'access_token is required');
      }
      final JWT jwt;
      try {
        jwt = JWT.verify(accessToken, SecretKey(secretKey()),
            issuer: 'degree_auth');
      } catch (e) {
        return Response.unauthorized('Invalid access_token');
      }

      final role = jwt.payload['role'].toString().split('.').last;

      if (role != 'admin') {
        return Response.unauthorized('Invalid role');
      }
      final List<User> users;
      try {
        users = await userRepository.getAllUsers();
      } catch (e) {
        return Response.internalServerError(body: '$e Users not found');
      }
      return Response.ok(jsonEncode(users
          .map((user) => {
                'id': user.id,
                'firstName': user.firstName,
                'secondName': user.secondName,
                'middleName': user.middleName,
                'username': user.username,
                'role': user.role.toString().split('.').last,
                'registerCode': user.registerCode,
              })
          .toList()));
    });
    // Delete user
    router.delete('/<id>', (Request req, String id) async {
      final int userId = int.parse(id);

      final params = req.url.queryParameters;
      final accessToken = params['access_token'];

      if (accessToken == null) {
        return Response.badRequest(body: 'access_token is required');
      }
      final JWT jwt;

      try {
        jwt = JWT.verify(accessToken, SecretKey(secretKey()),
            issuer: 'degree_auth');
      } catch (e) {
        return Response.unauthorized('Invalid access_token');
      }
      final role = jwt.payload['role'].toString().split('.').last;
      if (role != 'admin') {
        return Response.unauthorized('Invalid role');
      }

      if (!(await userRepository.existsUser(id: userId))) {
        return Response.notFound('User not found');
      }

      try {
        await userRepository.deleteUser(userId);
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }
      return Response.ok(jsonEncode({
        'status': 'ok',
        'message': 'User deleted',
      }));
    });

    return router;
  }
}
