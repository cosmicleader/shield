class Resource {
  String id;
  final String title;
  final String type;
  final String location;
  final bool isAvailable;
  final String ownerId;
  final List<String>
      requests; // Define the requests field as a list of user IDs

  Resource({
    required this.ownerId,
    required this.id,
    required this.title,
    required this.type,
    required this.location,
    required this.isAvailable,
    required this.requests,
  });
}
