class VolunteerRequest {
  final String id;
  final String? title;
  final String? description;
  final DateTime? postedTime;
  final String? requestType;

  VolunteerRequest({
    required this.id,
    required this.title,
    required this.description,
    required this.postedTime,
    required this.requestType,
  });
}
