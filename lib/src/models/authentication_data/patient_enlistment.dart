class PatientEnlistment {
  final String groupId;
  final DateTime expiryTimestamp;
  final bool expired;
  final DateTime creationTimestamp;

  PatientEnlistment({
    required this.groupId,
    required this.expiryTimestamp,
    required this.expired,
    required this.creationTimestamp,
  });
}
