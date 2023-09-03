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

  // factory VolunteerRequest.fromJson(Map<String, dynamic> json) {
  //   return VolunteerRequest(
  //     id: json['id'],
  //     title: json['title'],
  //     description: json['description'],
  //     postedTime: DateTime.parse(json['postedTime']),
  //     requestType: json['requestType'],
  //   );
  // }
}
