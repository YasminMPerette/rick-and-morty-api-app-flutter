import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rm_app/screens/detail_screen.dart';
import 'package:rm_app/services/rm_api_service.dart';
import '../models/character.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Character>> _futureCharacters;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _futureCharacters = _apiService.fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Character>>(
        future: _futureCharacters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final characters = snapshot.data!;
            return ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      onTap: () {
                        print("Clicou no personagem: ${character.name}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context)=>
                          Detail_screen(character)
                          )
                        );
                      },
                      leading: CachedNetworkImage(
                        imageUrl: character.image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, erro) =>
                            const Icon(Icons.error),
                      ),
                      title: Text(character.name),
                      subtitle: Text('Status: ${character.status}'),
                    ));
              },
            );
          }
          return const Center(child: Text('Nenhum dado disponível'));
        },
      ),
    );
  }
}
