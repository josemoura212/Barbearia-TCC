// ignore_for_file: public_member_api_docs, sort_constructors_first

class BarbershopModel {
  final int id;
  final String nome;
  final String email;
  final List<String> openingDays;
  final List<int> openingHours;
  BarbershopModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.openingDays,
    required this.openingHours,
  });

  factory BarbershopModel.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'nome': String nome,
        'email': String email,
        'opening_days': final List openingDays,
        'opening_hours': final List openingHours,
      } =>
        BarbershopModel(
          id: id,
          nome: nome,
          email: email,
          openingDays: openingDays.cast<String>(),
          openingHours: openingHours.cast<int>(),
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}
