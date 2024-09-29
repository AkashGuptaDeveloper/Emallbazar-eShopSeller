class DeliveryBoy {
  String id;
  String name;
  String mobile;
  String email;
  String balance;
  String city;
  String image;
  String area;
  String street;
  String status;
  String date;

  DeliveryBoy({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.balance,
    required this.city,
    required this.image,
    required this.area,
    required this.street,
    required this.status,
    required this.date,
  });

  factory DeliveryBoy.fromMap(Map<String, dynamic> map) {
    return DeliveryBoy(
      id: map['id'].toString(),
      name: map['name'].toString(),
      mobile: map['mobile'].toString(),
      email: map['email'].toString(),
      balance: map['balance'].toString(),
      city: map['city'].toString(),
      image: map['image'].toString(),
      area: map['area'].toString(),
      street: map['street'].toString(),
      status: map['status'].toString(),
      date: map['date'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'email': email,
      'balance': balance,
      'city': city,
      'image': image,
      'area': area,
      'street': street,
      'status': status,
      'date': date,
    };
  }
}
