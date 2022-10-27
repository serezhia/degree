import 'package:task_service/task_service.dart';

class TagsRoute {
  final TagRepository tagRepository;

  TagsRoute({required this.tagRepository});

  Handler get router {
    final router = Router();

    router.post('/', (Request req) async {
      final params = req.url.queryParameters;
      final name = params['name'];
      final role = req.context['role'];

      if (name == null) {
        return Response.badRequest(body: 'name is required');
      }

      switch (role) {
        case 'admin':
          break;
        case 'teacher':
          break;
        default:
          return Response.forbidden('Only admin and teacher can create tags');
      }

      if (await tagRepository.tagExists(name: name)) {
        return Response.badRequest(body: 'Tag with name $name already exists');
      }

      final Tag tag;
      try {
        tag = await tagRepository.createTag(name);
      } catch (e) {
        return Response.internalServerError(body: 'Error creating tag: $e');
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Tag created',
        'tag': {
          'name': tag.name,
          'id': tag.id,
        },
      }));
    });

    router.post('/<id>', (Request req, String id) async {
      final params = req.url.queryParameters;
      final name = params['name'];
      final role = req.context['role'];

      switch (role) {
        case 'admin':
          break;
        case 'teacher':
          break;
        default:
          return Response.forbidden('Only admin and teacher can update tags');
      }

      if (!await tagRepository.tagExists(id: int.parse(id))) {
        return Response.notFound('Tag with id $id not found');
      }

      if (name == null) {
        return Response.badRequest(body: 'name is required');
      }

      final Tag tag;
      try {
        tag = await tagRepository.updateTag(Tag(int.parse(id), name));
      } catch (e) {
        return Response.internalServerError(body: 'Error updating tag: $e');
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Tag updated',
        'tag': {
          'name': tag.name,
          'id': tag.id,
        },
      }));
    });

    router.get('/', (Request req) async {
      final tags = await tagRepository.getTags();
      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Tags retrieved',
        'tags': tags
            .map((tag) => {
                  'name': tag.name,
                  'id': tag.id,
                })
            .toList(),
      }));
    });

    router.get('/<id>', (Request req, String id) async {
      if (!await tagRepository.tagExists(id: int.parse(id))) {
        return Response.notFound('Tag with id $id not found');
      }

      final tag = await tagRepository.getTag(int.parse(id));
      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Tag retrieved',
        'tag': {
          'name': tag.name,
          'id': tag.id,
        },
      }));
    });

    router.delete('/<id>', (Request req, String id) async {
      final role = req.context['role'];

      switch (role) {
        case 'admin':
          break;
        case 'teacher':
          break;
        default:
          return Response.forbidden('Only admin and teacher can delete tags');
      }

      if (!await tagRepository.tagExists(id: int.parse(id))) {
        return Response.notFound('Tag with id $id not found');
      }

      await tagRepository.deleteTag(int.parse(id));
      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Tag deleted',
      }));
    });

    final handler =
        Pipeline().addMiddleware(checkAutorization()).addHandler(router);
    return handler;
  }
}
