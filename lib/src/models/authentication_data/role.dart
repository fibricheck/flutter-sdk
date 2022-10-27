import 'permission.dart';

class Role {
  final String id;
  final String name;
  final String description;
  final List<Permission> permissions;
  final DateTime creationTimestamp;
  final DateTime updateTimestamp;

  Role({
    required this.id,
    required this.name,
    required this.description,
    required this.permissions,
    required this.creationTimestamp,
    required this.updateTimestamp,
  });
}
