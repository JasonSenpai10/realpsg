class Detail {
  final int? id;
  final String latitude;
  final String longitude;
  final String type;
  final String price;
  final String details;
  final String photo;
  Detail({
    this.id,
    required this.latitude,
    required this.longitude,
    required this.type,
    required this.price,
    required this.details,
    required this.photo,
  });
  factory Detail.fromMap(Map<String, dynamic> json) => Detail(
        id: json['id'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        type: json['type'],
        price: json['price'],
        details: json['details'] ?? '',
        photo: json['photo'],
      );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'type': type,
      'price': price,
      'details': details,
      'photo': photo,
    };
  }
}
