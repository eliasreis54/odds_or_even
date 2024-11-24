import 'package:flutter/material.dart';
import 'package:odds_or_even/list_players.dart';
import 'package:odds_or_even/models/bet_result.dart';

class BetResultPage extends StatelessWidget {
  const BetResultPage({
    super.key,
    required this.betResult,
  });

  final BetResult betResult;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado do desafio'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: betResult.message != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage(
                      'assets/alert.png',
                    ),
                    width: MediaQuery.of(context).size.width * 0.60,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    betResult.message!,
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) {
                            return const ListPlayers();
                          },
                        ),
                      );
                    },
                    child: const Text('Jogar novamente'),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage(
                      'assets/winner.png',
                    ),
                    width: MediaQuery.of(context).size.width * 0.30,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: Card(
                      color: Colors.green[100],
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Text(
                              'Ganhador: ${betResult.winner?.username ?? ''}',
                              style: theme.textTheme.titleMedium,
                            ),
                            Text(
                              'Apostou: ${betResult.winner?.amount ?? ''}',
                            ),
                            Text(
                              'Escolheu: ${betResult.winner?.bet ?? ''}',
                            ),
                            Text(
                              'E jogou: ${betResult.winner?.betNumber ?? ''}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: Card(
                      color: Colors.red[100],
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Text(
                              'Perdedor: ${betResult.looser?.username ?? ''}',
                              style: theme.textTheme.titleMedium,
                            ),
                            Text(
                              'Apostou: ${betResult.looser?.amount ?? ''}',
                            ),
                            Text(
                              'Escolheu: ${betResult.looser?.bet ?? ''}',
                            ),
                            Text(
                              'E jogou: ${betResult.looser?.betNumber ?? ''}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) {
                            return const ListPlayers();
                          },
                        ),
                      );
                    },
                    child: const Text('Jogar novamente'),
                  ),
                ],
              ),
      ),
    );
  }
}
