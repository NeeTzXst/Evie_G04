class destination {
  final String? description;
  final double? latitude;
  final double? longitude;

  destination({
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'latitude': latitude,
      'longitude': longitude
    };
  }

  factory destination.fromJson(Map<String, dynamic> json) {
    return destination(
      description: json['description'] as String?,
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
    );
  }

  @override
  String toString() {
    return 'Description: $description , Latitude: $latitude , Longitude: $longitude';
  }
}
