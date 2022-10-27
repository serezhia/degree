import 'package:task_service/task_service.dart';

class FilesRoute {
  final TaskFileRepository fileRepository;

  FilesRoute({required this.fileRepository});

  Handler get router {
    final router = Router();

    router.post('/<pathFile|.*>', (Request req, String pathFile) async {
      final params = req.url.queryParameters;
      final String userId = req.context['user_id'].toString();
      final namesFileString = params['names_file'];

      if (namesFileString == null) {
        return Response(400, body: 'names_file is required');
      }

      final namesFile = namesFileString.split(',');

      Directory directory = Directory('user_files');

      Directory userDirectory =
          Directory('${directory.path}/$userId/$pathFile');
      if (!userDirectory.existsSync()) {
        userDirectory.createSync(recursive: true);
      }

      File file;
      final contentType = req.headers['content-type'];
      if (contentType == null) {
        return Response(400, body: 'Missing content-type');
      }

      final mediaType = MediaType.parse(contentType);
      if (mediaType.mimeType != 'multipart/form-data') {
        return Response(400, body: 'Invalid content-type');
      }

      final boundary = mediaType.parameters['boundary'];
      if (boundary == null) {
        return Response(400, body: 'Missing boundary');
      }

      final payload = req.read();
      List<File> files = [];
      final parts =
          await MimeMultipartTransformer(boundary).bind(payload).toList();
      for (final part in parts) {
        String fileName = sha256
            .convert(utf8.encode(userId +
                DateTime.now().toString() +
                Random.secure().nextInt(parts.length).toString()))
            .toString();

        switch (part.headers['content-type']) {
          case 'image/jpeg':
            fileName += '.jpg';
            break;
          case 'image/png':
            fileName += '.png';
            break;
          case 'text/plain':
            fileName += '.txt';
            break;
          case 'application/pdf':
            fileName += '.pdf';
            break;
          case 'application/msword':
            fileName += '.doc';
            break;
          case 'application/vnd.openxmlformats-officedocument.wordprocessingml.document':
            fileName += '.docx';
            break;
          default:
            return Response(400, body: 'Invalid content-type');
        }
        file = File('${userDirectory.path}/$fileName');
        if (await file.exists()) {
          await file.delete();
        }
        final chunks = await part.toList();
        for (final chunk in chunks) {
          await file.writeAsBytes(chunk, mode: FileMode.append);
        }
        files.add(file);
      }

      List<TaskFile> taskFiles = [];

      if (files.isEmpty) {
        return Response.internalServerError(body: 'Error while uploading file');
      }

      try {
        for (var file in files) {
          final fileDb = await fileRepository.createFile(
            userId: int.parse(userId),
            name:
                '${namesFile[files.indexWhere((element) => file == element)]}.${file.path.split('.').last}',
            url: file.path,
            size: file.lengthSync(),
          );
          taskFiles.add(fileDb);
        }
      } catch (e) {
        return Response.internalServerError(
            body: 'Incorrect amount of names and uploaded files $e');
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Файлы успешно загружен',
        'files': taskFiles
            .map((e) => {
                  'id': e.id,
                  'name': e.name,
                  'url': e.url,
                  'size': e.size,
                  'created_at': e.createdAt.toIso8601String(),
                })
            .toList()
      }));
    });

    router.get('/', (Request req) async {
      final String? userId = req.context['user_id'] as String?;

      if (userId == null) {
        return Response.badRequest(body: 'user_id is required');
      }

      final files = await fileRepository.getAllFiles(int.parse(userId));

      if (files.isEmpty) {
        return Response.ok(jsonEncode({
          'status': 'success',
          'message': 'Файлы не найдены',
          'files': [],
        }));
      }
      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Информация o всех файлах пользователя получена',
        'files': files
            .map((e) => {
                  'id': e?.id,
                  'name': e?.name,
                  'url': e?.url,
                  'size': e?.size,
                  'created_at': e?.createdAt.toIso8601String(),
                })
            .toList()
      }));
    });

    router.get('/<fileId>', (Request req, String fileId) async {
      final String userId = req.context['user_id'] as String;

      final TaskFile file = await fileRepository.getFile(int.parse(fileId));

      if (int.tryParse(userId) != file.userId) {
        return Response.forbidden('You dont have access to this file');
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Информация о файле получена',
        'file': {
          'id': file.id,
          'name': file.name,
          'url': file.url,
          'size': file.size,
          'created_at': file.createdAt.toIso8601String(),
        }
      }));
    });

    router.get('/user_files/<fileId>', (Request req, String fileId) async {
      final TaskFile fileDb = await fileRepository.getFile(int.parse(fileId));

      final file = File(fileDb.url);

      print(fileDb.url);
      if (!file.existsSync()) {
        return Response.notFound('File not found');
      }

      final Stream<List> a = file.readAsBytes().asStream();

      final translit =
          Translit().toTranslit(source: fileDb.name.split('.').first);

      switch (fileDb.url.split('.').last) {
        case 'png':
          return Response.ok(a, headers: {
            'Content-Type': 'image/png',
            'Content-Disposition': 'attachment; filename="$translit.png"',
          });
        case 'txt':
          return Response.ok(a, headers: {
            'Content-Type': 'text/plain',
            'Content-Disposition': 'attachment; filename="$translit.txt"',
          });
        case 'pdf':
          return Response.ok(a, headers: {
            'Content-Type': 'application/pdf',
            'Content-Disposition': 'attachment; filename="$translit.pdf"',
          });
        case 'doc':
          return Response.ok(a, headers: {
            'Content-Type': 'application/msword',
            'Content-Disposition': 'attachment; filename="$translit.doc"',
          });
        case 'docx':
          return Response.ok(a, headers: {
            'Content-Type':
                'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
            'Content-Disposition': 'attachment; filename="$translit.docx"',
          });
      }
    });

    router.delete('/<fileId>', (Request req, String fileId) async {
      final userId = req.context['user_id'] as String;

      final TaskFile file;

      if (!await fileRepository.isFileExist(int.parse(fileId))) {
        return Response.notFound('File not found');
      }

      try {
        file = await fileRepository.getFile(int.parse(fileId));
      } catch (e) {
        return Response.badRequest(body: 'file_id is incorrect $e');
      }

      if (file.userId != int.parse(userId)) {
        return Response.ok(jsonEncode({
          'status': 'success',
          'message': 'Файл не найден',
        }));
      }

      await fileRepository.deleteFile(int.parse(fileId));

      await File(file.url).delete();

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Файл успешно удален',
      }));
    });

    final handler =
        Pipeline().addMiddleware(checkAutorization()).addHandler(router);

    return handler;
  }
}






//  if (userId == null) {
//         return Response.badRequest(body: 'user_id is required');
//       }
//       final file = File(
//               'user_files/$userId/3c8d1c19dcddf541e052d3ceb8bb5cb92671164048856cfe705ce2e79ec2d599.png')
//           .readAsBytes();

//       final Stream<List> a = file.asStream();

//       return Response.ok(a, headers: {
//         'Content-Type': 'image/png',
//         'Content-Disposition': 'attachment; filename="test.png"',
//       });