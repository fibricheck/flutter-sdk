import '../../models/authentication_data/group_role.dart';

class StaffEnlistment {
  final String groupId;
  final List<GroupRole> roles;
  final DateTime creationTimestamp;
  final DateTime updateTimestamp;

  StaffEnlistment({
    required this.groupId,
    required this.roles,
    required this.creationTimestamp,
    required this.updateTimestamp,
  });
}
