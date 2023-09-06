class VolunteerRequest {
  final String id;
  final String ownerId;
  final String? title;
  final String? description;
  final DateTime? postedTime;
  final String? requestType;

  VolunteerRequest({
    required this.ownerId,
    required this.id,
    required this.title,
    required this.description,
    required this.postedTime,
    required this.requestType,
  });
}
