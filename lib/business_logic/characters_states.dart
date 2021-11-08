import 'package:bloc_app/data/models/character.dart';
import 'package:bloc_app/data/models/quote.dart';


abstract class CharactersStates{}

class InitialCharacterState extends CharactersStates{}

class CharactersLoadedState extends CharactersStates{
  final List<Character> characters;

  CharactersLoadedState(this.characters);
}

class QuotesLoadedState extends CharactersStates{
  final List<Quote> quotes;

  QuotesLoadedState(this.quotes);
}
