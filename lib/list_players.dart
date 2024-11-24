import 'package:flutter/material.dart';
import 'package:odds_or_even/bet_result_page.dart';
import 'package:odds_or_even/models/gambler.dart';
import 'package:odds_or_even/repositories/game_repository.dart';
import 'package:provider/provider.dart';

class ListPlayers extends StatefulWidget {
  const ListPlayers({super.key});

  @override
  State<ListPlayers> createState() => _ListPlayersState();
}

class _ListPlayersState extends State<ListPlayers> {
  List<Gambler> bettors = [];
  bool loading = true;
  int? selectedOpponent;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    final repository = context.read<GameRepository>();
    final response = await repository.listPlayers();
    final userScore = await repository.getPlayerScore();
    setState(() {
      bettors = response;
      loading = false;
      score = userScore;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Faça sua aposta'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Confira a lista de apostas e selecione seu oponente',
                    style: theme.textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Você tem $score pontos',
                    style: theme.textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ListTile(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                key: Key(index.toString()),
                                tileColor: Colors.black12,
                                leading: Checkbox(
                                  value: index == selectedOpponent,
                                  onChanged: (_) {
                                    setState(() {
                                      selectedOpponent = index;
                                    });
                                  },
                                ),
                                title: Text(bettors[index].username),
                                subtitle: Text(
                                    'Apostou: ${bettors[index].betPoints}'),
                                onTap: () {
                                  setState(() {
                                    selectedOpponent = index;
                                  });
                                },
                                trailing: const Icon(Icons.ads_click),
                              ));
                        },
                        itemCount: bettors.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(5.0),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (selectedOpponent != null) {
                        try {
                          final betResult = await context
                              .read<GameRepository>()
                              .executeBet(
                                userName2: bettors[selectedOpponent!].username,
                              );

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) {
                                return BetResultPage(betResult: betResult);
                              },
                            ),
                          );
                        } on GameException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.cause),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Você presisa selecionar um oponente',
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Desafiar'),
                  ),
                ],
              ),
            ),
    );
  }
}
