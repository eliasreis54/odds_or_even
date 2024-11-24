import 'package:json_annotation/json_annotation.dart';

part 'gambler.g.dart';

@JsonSerializable()
class Gambler {
  final String username;
  @JsonKey(name: 'valor', defaultValue: 0)
  final double amount;
  @JsonKey(name: 'parimpar', defaultValue: 0)
  final int bet;
  @JsonKey(name: 'numero', defaultValue: 0)
  final int betNumber;
  @JsonKey(name: 'pontos', defaultValue: 0)
  final int betPoints;

  Gambler({
    required this.username,
    required this.amount,
    required this.bet,
    required this.betNumber,
    required this.betPoints,
  });

  factory Gambler.fromJson(Map<String, dynamic> json) =>
      _$GamblerFromJson(json);

  Map<String, dynamic> toJson() => _$GamblerToJson(this);
}
