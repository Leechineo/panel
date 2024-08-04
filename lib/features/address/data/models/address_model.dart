import 'package:leechineo_panel/features/address/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    required super.id,
    required super.user,
    required super.zipcode,
    required super.city,
    required super.name,
    required super.state,
    required super.district,
    required super.street,
    required super.number,
    required super.complement,
    required super.reference,
    required super.phone,
    required super.createdAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? '',
      user: json['user'] ?? '',
      zipcode: json['zipcode'] ?? '',
      city: json['city'] ?? '',
      name: json['name'] ?? '',
      state: json['state'] ?? '',
      district: json['district'] ?? '',
      street: json['street'] ?? '',
      number: json['number'] ?? '',
      complement: json['complement'] ?? '',
      reference: json['reference'] ?? '',
      phone: json['phone'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  AddressModel copyWith({
    String? id,
    String? user,
    String? zipcode,
    String? city,
    String? name,
    String? state,
    String? district,
    String? street,
    String? number,
    String? complement,
    String? reference,
    String? phone,
    DateTime? createdAt,
  }) {
    return AddressModel(
      id: id ?? this.id,
      user: user ?? this.user,
      zipcode: zipcode ?? this.zipcode,
      city: city ?? this.city,
      name: name ?? this.name,
      state: state ?? this.state,
      district: district ?? this.district,
      street: street ?? this.street,
      number: number ?? this.number,
      complement: complement ?? this.complement,
      reference: reference ?? this.reference,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory AddressModel.newWith({
    String? id,
    String? user,
    String? zipcode,
    String? city,
    String? name,
    String? state,
    String? district,
    String? street,
    String? number,
    String? complement,
    String? reference,
    String? phone,
    DateTime? createdAt,
  }) {
    return AddressModel(
      id: id ?? '',
      user: user ?? '',
      zipcode: zipcode ?? '',
      city: city ?? '',
      name: name ?? '',
      state: state ?? '',
      district: district ?? '',
      street: street ?? '',
      number: number ?? '',
      complement: complement ?? '',
      reference: reference ?? '',
      phone: phone ?? '',
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'zipcode': zipcode,
      'city': city,
      'name': name,
      'state': state,
      'district': district,
      'street': street,
      'number': number,
      'complement': complement,
      'reference': reference,
      'phone': phone,
      'createdAt': createdAt.toString(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
