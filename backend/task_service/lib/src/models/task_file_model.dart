class TaskFile {
  final int id;
  final int userId;
  final String name;
  final String url;
  final int size;
  final DateTime createdAt;

  TaskFile({
    required this.id,
    required this.userId,
    required this.name,
    required this.url,
    required this.size,
    required this.createdAt,
  });
}
