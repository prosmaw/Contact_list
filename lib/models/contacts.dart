class Contact {
  int id;

  String first;
  String last;
  String email;
  String birthDate;

  String phone;
  String pictureLink;
  String country;
  String state;
  String city;

  String streetName;
  int streetNumber;

  Contact(
      {required this.first,
      required this.last,
      required this.birthDate,
      required this.email,
      required this.id,
      required this.country,
      required this.state,
      required this.city,
      required this.streetName,
      required this.streetNumber,
      required this.phone,
      required this.pictureLink});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first': first,
      'last': last,
      'email': email,
      'birthDate': birthDate,
      'phone': phone,
      'pictureLink': pictureLink,
      'country': country,
      'state': state,
      'city': city,
      'streetName': streetName,
      'streetNumber': streetNumber,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],

      first: map['first'],
      last: map['last'],
      email: map['email'],
      birthDate: map['birthDate'],

      phone: map['phone'],
      pictureLink: map['pictureLink'],
      country: map['country'],
      state: map['state'],
      city: map['city'],
      //postcode: map['postcode'],

      streetName: map['streetName'],
      streetNumber: map['streetNumber'],
    );
  }
}
