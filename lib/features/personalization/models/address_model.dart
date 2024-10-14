class Address {
  String name;
  String phoneNumber;
  String street;
  String postalCode;
  String city;
  String stateOrDistrict;
  String country;

  Address({
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.postalCode,
    required this.city,
    required this.stateOrDistrict,
    required this.country,
  });

  // Convert an Address object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'street': street,
      'postalCode': postalCode,
      'city': city,
      'stateOrDistrict': stateOrDistrict,
      'country': country,
    };
  }

  // Convert a Map object into an Address object
  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      street: map['street'],
      postalCode: map['postalCode'],
      city: map['city'],
      stateOrDistrict: map['stateOrDistrict'],
      country: map['country'],
    );
  }
}
