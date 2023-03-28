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
      "Destination": {
        'description': description,
        'destination_latitude': latitude,
        'destination_longitude': longitude,
      }
    };
  }

  factory destination.fromJson(Map<String, dynamic> json) {
    return destination(
      description: json['description'] as String?,
      latitude: json['destination_latitude'] as double?,
      longitude: json['destination_longitude'] as double?,
    );
  }

  @override
  String toString() {
    return 'Description: $description , Latitude: $latitude , Longitude: $longitude';
  }
}
