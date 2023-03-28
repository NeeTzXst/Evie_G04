class currentLocation {
  final String? description;
  final double? latitude;
  final double? longitude;

  currentLocation({
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      "Current_Location": {
        'description': description,
        'current_latitude': latitude,
        'current_longitude': longitude,
      }
    };
  }

  factory currentLocation.fromJson(Map<String, dynamic> json) {
    return currentLocation(
      description: json['description'] as String?,
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
    );
  }

  @override
  String toString() {
    return 'description: $description Latitude : $latitude , Longiitude : $longitude';
  }
}
