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
      'title',
      'issuers',
      'addresses'
    ],
  );
  return Expense._(
    json['id'] as String,
    DateTime.parse(json['createdAt'] as String),
    DateTime.parse(json['updatedAt'] as String),
    (json['amount'] as num).toDouble(),
    json['title'] as String,
    (json['issuers'] as List<dynamic>).map((e) => e as String).toList(),
    (json['addresses'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$ExpenseToJson(Expense instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'amount': instance.amount,
      'title': instance.title,
      'issuers': instance.issuers,
      'addresses': instance.addresses,
    };
