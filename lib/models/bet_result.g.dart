// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bet_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BetResult _$BetResultFromJson(Map<String, dynamic> json) => BetResult(
      winner: json['vencedor'] == null
          ? null
          : Gambler.fromJson(json['vencedor'] as Map<String, dynamic>),
      looser: json['perdedor'] == null
          ? null
          : Gambler.fromJson(json['perdedor'] as Map<String, dynamic>),
      message: json['msg'] as String?,
    );

Map<String, dynamic> _$BetResultToJson(BetResult instance) => <String, dynamic>{
      'vencedor': instance.winner,
      'perdedor': instance.looser,
      'msg': instance.message,
    };
