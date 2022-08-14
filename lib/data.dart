class Detail {
  final int? id;
  final String latitude;
  final String longitude;
  final String type;
  final String price;
  Detail ( {this.id, required this.type, required this.price, required this.latitude, required this.longitude,});
  factory Detail.fromMap(Map<String, dynamic> json) =>  Detail(
id: json['id'],
latitude: json['latitude'], 
longitude: json['longitude'], 
type: json['type'],
price: json['price']
  );
  Map< String, dynamic> toMap(){
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'type': type,
      'price': price,
    };
  } 
}