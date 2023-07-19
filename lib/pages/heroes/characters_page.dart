import 'package:appheroes/model/characters_model.dart';
import 'package:appheroes/repositories/marvel_repository.dart';
import 'package:appheroes/shared/widgets/custon_drawer.dart';
import 'package:flutter/material.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final ScrollController _scrollController = ScrollController();
  late MarvelRepository marvelRepository;
  CharactersModel characters = CharactersModel();
  int offset = 0;
  var carregando = false;
  @override
  void initState() {
    _scrollController.addListener(() {
      var posicaoParaPaginar = _scrollController.position.maxScrollExtent * 0.7;
      if (_scrollController.position.pixels > posicaoParaPaginar) {
        carregarDados();
      }
    });
    marvelRepository = MarvelRepository();
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    if (carregando) return;
    if (characters.data == null || characters.data!.results == null) {
      characters = await marvelRepository.getcharacters(offset);
    } else {
      setState(() {
        carregando = true;
      });
      offset = offset + characters.data!.count!;
      var tempList = await marvelRepository.getcharacters(offset);
      characters.data!.results!.addAll(tempList.data!.results!);
      carregando = false;
    }
    setState(() {});
  }

  int retornaQuantidadeTotal() {
    try {
      return characters.data!.total!;
    } catch (e) {
      return 0;
    }
  }

  int retornaQuantidadeAtual() {
    try {
      return offset + characters.data!.count!;
    } catch (e) {
      return 0;
    }
  }

  void _showModal(Results character) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            character.name!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Image.network(
                          "${character.thumbnail!.path!}.${character.thumbnail!.extension!}",
                          width: 200,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Descrição",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                character.description!.length < 3
                                    ? "Sem descrição"
                                    : character.description!,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    child: const Text('Fechar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
            "Heróis: ${retornaQuantidadeAtual()}/${retornaQuantidadeTotal()}"),
      ),
      drawer: const CustonDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                controller: _scrollController,
                itemCount: (characters.data == null ||
                        characters.data!.results == null)
                    ? 0
                    : characters.data!.results!.length,
                itemBuilder: (_, int index) {
                  var character = characters.data!.results![index];
                  return GestureDetector(
                    onTap: () {
                      _showModal(character);
                    },
                    child: Card(
                      elevation: 3,
                      borderOnForeground: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: Theme.of(context)
                              .primaryColor, // Set your desired border color here
                          width: 2.0, //  Set your desired border width here
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            "${character.thumbnail!.path!}.${character.thumbnail!.extension!}",
                            width: 150,
                            height: 150,
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    character.name!,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(character.description!),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          !carregando
              ? ElevatedButton(
                  onPressed: () {
                    carregarDados();
                  },
                  child: const Text("Carregar mais itens"))
              : const CircularProgressIndicator()
        ],
      ),
    ));
  }
}
