// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expense _$ExpenseFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'createdAt',
      'amount',
      'description',
      'issuer',
      'addresses',
      'flat'
    ],
  );
  return Expense._(
    json['id'] as String,
    DateTime.parse(json['createdAt'] as String),
    DateTime.parse(json['updatedAt'] as String),
    (json['amount'] as num).toDouble(),
    json['description'] as String?,
    Mate.fromJson(json['issuer']),
    (json['addresses'] as List<dynamic>).map((e) => Mate.fromJson(e)).toList(),
    json['flat'] as String,
  );
}

Map<String, dynamic> _$ExpenseToJson(Expense instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'amount': instance.amount,
      'description': instance.description,
      'issuer': instance.issuer,
      'addresses': instance.addresses,
      'flat': instance.flat,
    };
