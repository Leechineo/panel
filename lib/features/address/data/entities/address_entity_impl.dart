import 'package:leechineo_panel/features/address/domain/entities/address_entity.dart';

class AddressEntityImpl extends AddressEntity {
  AddressEntityImpl({
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

  AddressEntityImpl copyWith({
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
    return AddressEntityImpl(
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

  factory AddressEntityImpl.newWith({
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
    return AddressEntityImpl(
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

  factory AddressEntityImpl.fromEntity(AddressEntity addressEntity) {
    return AddressEntityImpl(
      id: addressEntity.id,
      user: addressEntity.user,
      zipcode: addressEntity.zipcode,
      city: addressEntity.city,
      name: addressEntity.name,
      state: addressEntity.state,
      district: addressEntity.district,
      street: addressEntity.street,
      number: addressEntity.number,
      complement: addressEntity.complement,
      reference: addressEntity.reference,
      phone: addressEntity.phone,
      createdAt: addressEntity.createdAt,
    );
  }
}
