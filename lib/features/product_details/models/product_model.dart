class RateModel {
  int? id;
  DateTime? createdAt;
  int? rate;
  String? forUsers;
  String? forProducts;

  RateModel({
    this.id,
    this.createdAt,
    this.rate,
    this.forUsers,
    this.forProducts,
  });

  factory RateModel.fromJson(Map<String, dynamic> json) => RateModel(
    id: json['id'] as int?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    rate: json['rate'] as int?,
    forUsers: json['for_users'] as String?,
    forProducts: json['for_products'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt?.toIso8601String(),
    'rate': rate,
    'for_users': forUsers,
    'for_products': forProducts,
  };
}
