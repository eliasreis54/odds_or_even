import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:odds_or_even/models/bet_result.dart';
import 'package:odds_or_even/models/gambler.dart';

const _baseUrl = 'https://par-impar.glitch.me';

class GameException implements Exception {
  String cause;
  GameException(this.cause);
}

class GameRepository {
  final http.Client client;

  String _myself = '';

  GameRepository({
    required this.client,
  });

  Future<bool> createUser({
    required String userName,
  }) async {
    final uri = Uri.parse('$_baseUrl/novo');

    try {
      await client.post(
        uri,
        body: jsonEncode({
          'username': userName,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      _myself = userName;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> bet({
    required String userName,
    required double amount,
    required int oddOrEven,
    required int betNumber,
  }) async {
    final uri = Uri.parse('$_baseUrl/aposta');
    await client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': userName,
        'valor': amount,
        'parimpar': oddOrEven,
        'numero': betNumber,
      }),
    );
  }

  Future<List<Gambler>> listPlayers() async {
    final uri = Uri.parse('$_baseUrl/jogadores');
    final result = await client.get(uri);

    final listResponse = jsonDecode(result.body);
    final bettors = listResponse['jogadores'] ?? [];

    final List<Gambler> bettorsResponse = [];
    for (final json in bettors) {
      bettorsResponse.add(Gambler.fromJson(json));
    }

    return bettorsResponse;
  }

  Future<BetResult> executeBet({
    required String userName2,
  }) async {
    if (userName2 == _myself) {
      throw GameException('Não se pode competir com você mesmo');
    }

    final uri = Uri.parse('$_baseUrl/jogar/$_myself/$userName2');
    final result = await client.get(uri);

    final jsonBody = jsonDecode(result.body);

    return BetResult.fromJson(jsonBody);
  }

  Future<int> getPlayerScore() async {
    final uri = Uri.parse('$_baseUrl/pontos/$_myself');
    final result = await client.get(uri);

    final body = jsonDecode(result.body);

    return body['pontos'] ?? 0;
  }
}
