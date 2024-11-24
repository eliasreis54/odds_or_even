import 'package:json_annotation/json_annotation.dart';
import 'package:odds_or_even/models/gambler.dart';

part 'bet_result.g.dart';

@JsonSerializable()
class BetResult {
  @JsonKey(name: 'vencedor')
  final Gambler? winner;
  @JsonKey(name: 'perdedor')
  final Gambler? looser;
  @JsonKey(name: 'msg')
  final String? message;

  BetResult({
    this.winner,
    this.looser,
    this.message,
  });

  factory BetResult.fromJson(Map<String, dynamic> json) =>
      _$BetResultFromJson(json);

  Map<String, dynamic> toJson() => _$BetResultToJson(this);
}
