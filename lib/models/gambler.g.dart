// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gambler.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gambler _$GamblerFromJson(Map<String, dynamic> json) => Gambler(
      username: json['username'] as String,
      amount: (json['valor'] as num?)?.toDouble() ?? 0,
      bet: (json['parimpar'] as num?)?.toInt() ?? 0,
      betNumber: (json['numero'] as num?)?.toInt() ?? 0,
      betPoints: (json['pontos'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$GamblerToJson(Gambler instance) => <String, dynamic>{
      'username': instance.username,
      'valor': instance.amount,
      'parimpar': instance.bet,
      'numero': instance.betNumber,
      'pontos': instance.betPoints,
    };
