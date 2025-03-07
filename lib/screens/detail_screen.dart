import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rm_app/models/character.dart';

class Detail_screen extends StatefulWidget {
  final Character character;

  const Detail_screen(this.character, {super.key});

  @override
  State<Detail_screen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<Detail_screen> {
  @override
  Widget build(BuildContext context) {
    final character = widget.character;
    return Scaffold(
        appBar: AppBar(
          title: Text(character.name),
          centerTitle: true,
        ),
        body: Card(
            child: Column(
              children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(imageUrl: character.image),
              Text("Status: ${character.status}", style: const TextStyle(fontSize: 20)),
              Text("Location: ${character.locatonName}", style: const TextStyle(fontSize: 20)),
              Text("Gender: ${character.gender}", style: const TextStyle(fontSize: 20)),
              Text("Species: ${character.species}", style: const TextStyle(fontSize: 20)),
            ],
          ),
          const SizedBox(height: 16),
          
            ]
          )
        ) 
      );
  }
}
