import 'package:flutter/material.dart';
import 'package:odds_or_even/list_players.dart';
import 'package:odds_or_even/models/gambler.dart';
import 'package:odds_or_even/repositories/game_repository.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    Provider<GameRepository>(
      create: (_) => GameRepository(client: http.Client()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Par ou ímpar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _amontController = TextEditingController();
  final TextEditingController _betNumberController = TextEditingController();

  int selectedBet = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage(
                'assets/home.png',
              ),
              width: MediaQuery.of(context).size.width * 0.60,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Bem vindo ao par ou impar',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog<Gambler>(
                  context: context,
                  builder: (BuildContext context) {
                    int bet = 0;
                    return Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUnfocus,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Para começar, identifique-se.',
                                style: theme.textTheme.titleLarge,
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                controller: _userNameController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Qual o seu nome?',
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return null;
                                  }
                                  return value.isEmpty
                                      ? 'Nome não pode ser vazio'
                                      : null;
                                },
                                style: theme.textTheme.bodyLarge,
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Text(
                                'Quantos pontos você quer apostar?',
                                style: theme.textTheme.titleLarge,
                              ),
                              const SizedBox(height: 15),
                              IntrinsicWidth(
                                child: TextFormField(
                                  controller: _amontController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Pontos da aposta',
                                  ),
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Text(
                                'Entre 1 e 5, qual vai ser sua aposta?',
                                style: theme.textTheme.titleLarge,
                              ),
                              const SizedBox(height: 15),
                              IntrinsicWidth(
                                child: TextFormField(
                                  controller: _betNumberController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Valor ente 1 e 5',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null) {
                                      return null;
                                    }
                                    final intValue = int.tryParse(value);
                                    if (intValue == null) {
                                      return 'Caracter inválido';
                                    }
                                    return intValue >= 1 && intValue <= 5
                                        ? null
                                        : 'Aposta deve ser entre 1 e 5';
                                  },
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Text(
                                'Você quer par ou ímpar?',
                                style: theme.textTheme.titleLarge,
                              ),
                              const SizedBox(height: 15),
                              IntrinsicWidth(
                                child: StatefulBuilder(
                                    builder: (context, builderState) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          bet = 2;
                                          builderState(() {
                                            selectedBet = 2;
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: selectedBet == 2
                                              ? Colors.purple[100]
                                              : null,
                                        ),
                                        child: const Text('Par'),
                                      ),
                                      const SizedBox(width: 24),
                                      ElevatedButton(
                                        onPressed: () {
                                          bet = 1;
                                          builderState(() {
                                            selectedBet = 1;
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: selectedBet == 1
                                              ? Colors.purple[100]
                                              : null,
                                        ),
                                        child: const Text('Ímpar'),
                                      )
                                    ],
                                  );
                                }),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                    Gambler(
                                      username: _userNameController.text,
                                      amount: double.tryParse(
                                              _amontController.text) ??
                                          0,
                                      bet: bet,
                                      betNumber:
                                          int.parse(_betNumberController.text),
                                      betPoints: 0,
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Prosseguir',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ).then((Gambler? value) async {
                  if (value == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Falha ao cadastrar usuário'),
                      ),
                    );
                  } else {
                    final success =
                        await context.read<GameRepository>().createUser(
                              userName: value.username,
                            );
                    if (success == true) {
                      await context.read<GameRepository>().bet(
                            userName: value.username,
                            amount: value.amount,
                            oddOrEven: value.bet,
                            betNumber: value.betNumber,
                          );

                      _userNameController.clear();
                      _amontController.clear();
                      _betNumberController.clear();
                      selectedBet = 0;

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) {
                            return const ListPlayers();
                          },
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Falha ao cadastrar usuário'),
                        ),
                      );
                    }
                  }
                });
              },
              child: Text(
                'Jogar',
                style: theme.textTheme.headlineSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
