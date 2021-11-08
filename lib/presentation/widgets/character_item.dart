
import 'package:bloc_app/constants/colors.dart';
import 'package:bloc_app/constants/strings.dart';
import 'package:bloc_app/data/models/character.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          characterDetailScreen,
          arguments: character,
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsetsDirectional.all(8),
        padding: const EdgeInsetsDirectional.all(4),
        decoration: BoxDecoration(
          color: MYColors.myWhite,
          borderRadius: BorderRadius.circular(8),
        ),
        child: GridTile(
          child: Hero(
            tag: character.charId,
            child: Container(
              color: MYColors.myGrey,
              child: character.image.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: 'assets/images/loading.gif',
                      image: character.image,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/images/placeholder.jpg'),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              character.name,
              style: const TextStyle(
                height: 1.3,
                fontSize: 16,
                color: MYColors.myWhite,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
