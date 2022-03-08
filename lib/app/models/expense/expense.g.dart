// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expense _$ExpenseFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const [
      'id',
      'amount',
      'description',
      'issuerId',
      'addresseeIds',
      'timestamp'
    ],
    requiredKeys: const [
      'id',
      'amount',
      'description',
      'issuerId',
      'addresseeIds',
      'timestamp'
    ],
  );
  return Expense._(
    json['id'] as String,
    (json['amount'] as num).toDouble(),
    json['description'] as String?,
    json['issuerId'] as String,
    (json['addresseeIds'] as List<dynamic>).map((e) => e as String).toList(),
    DateTime.parse(json['timestamp'] as String),
  );
}

Map<String, dynamic> _$ExpenseToJson(Expense instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'description': instance.description,
      'issuerId': instance.issuerId,
      'addresseeIds': instance.addresseeIds,
      'timestamp': instance.timestamp.toIso8601String(),
    };
