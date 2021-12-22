// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expense _$ExpenseFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'amount',
      'description',
      'issuers',
      'addresses',
      'flat'
    ],
  );
  return Expense(
    flat: json['flat'] as String,
    amount: (json['amount'] as num).toDouble(),
    description: json['description'] as String? ?? '',
    issuers:
        (json['issuers'] as List<dynamic>).map((e) => e as String).toList(),
    addresses:
        (json['addresses'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$ExpenseToJson(Expense instance) => <String, dynamic>{
      'amount': instance.amount,
      'description': instance.description,
      'issuers': instance.issuers,
      'addresses': instance.addresses,
      'flat': instance.flat,
    };
