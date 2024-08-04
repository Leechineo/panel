abstract class AddressEntity {
  final String id;
  final String user;
  final String zipcode;
  final String city;
  final String name;
  final String state;
  final String district;
  final String street;
  final String number;
  final String complement;
  final String reference;
  final String phone;
  final DateTime createdAt;

  AddressEntity({
    required this.id,
    required this.user,
    required this.zipcode,
    required this.city,
    required this.name,
    required this.state,
    required this.district,
    required this.street,
    required this.number,
    required this.complement,
    required this.reference,
    required this.phone,
    required this.createdAt,
  });
}
