class GroupRole {
  final String id;
  final String groupId;
  final String name;
  final String description;
  final List<String> permissions;
  final DateTime creationTimestamp;
  final DateTime updateTimestamp;

  GroupRole({
    required this.id,
    required this.groupId,
    required this.name,
    required this.description,
    required this.permissions,
    required this.creationTimestamp,
    required this.updateTimestamp,
  });
}
