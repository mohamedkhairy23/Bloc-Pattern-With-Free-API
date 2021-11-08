import 'package:bloc/bloc.dart';
import 'package:bloc_app/data/models/character.dart';
import 'package:bloc_app/data/repository/characters_repository.dart';


import 'characters_states.dart';

class CharactersCubit extends Cubit<CharactersStates>{
  CharactersCubit(this.charactersRepository) : super(InitialCharacterState());

  final CharactersRepository charactersRepository;
  List<Character> characters= [];

  List<Character>? getAllCharacters (){
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoadedState(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getQuotes (String charName){
    charactersRepository.getCharacterQuotes(charName).then((quotes) {
      emit(QuotesLoadedState(quotes));
    });
  }
}
