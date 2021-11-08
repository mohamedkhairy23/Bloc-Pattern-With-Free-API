import 'package:bloc_app/presentation/screens/character_details_screen.dart';
import 'package:bloc_app/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/characters_cubit.dart';
import 'constants/strings.dart';
import 'data/models/character.dart';
import 'data/repository/characters_repository.dart';
import 'data/web_services/characters_web_services.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => CharactersCubit(
              CharactersRepository(
                CharactersWebServices(),
              ),
            ),
            child: const CharactersScreen(),
          ),
        );
      case characterDetailScreen:
        final selectedCharacter = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => CharactersCubit(
              CharactersRepository(
                CharactersWebServices(),
              ),
            ),
            child: CharacterDetailsScreen(
              selectedCharacter: selectedCharacter,
            ),
          ),
        );
    }
  }
}
