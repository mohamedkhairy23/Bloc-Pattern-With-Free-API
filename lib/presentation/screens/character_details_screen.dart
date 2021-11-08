import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bloc_app/business_logic/characters_cubit.dart';
import 'package:bloc_app/business_logic/characters_states.dart';
import 'package:bloc_app/constants/colors.dart';
import 'package:bloc_app/data/models/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character selectedCharacter;

  const CharacterDetailsScreen({Key? key, required this.selectedCharacter})
      : super(key: key);

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 500,
      pinned: false,
      stretch: false,
      backgroundColor: MYColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          selectedCharacter.nickName,
          style: const TextStyle(color: MYColors.myWhite),
        ),
        background: Hero(
          tag: selectedCharacter.charId,
          child: Image.network(
            selectedCharacter.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MYColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: MYColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget myDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MYColors.myYellow,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(selectedCharacter.name);
    return Scaffold(
      backgroundColor: MYColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo(
                          "Job : ", selectedCharacter.jobs.join(" & ")),
                      myDivider(335),
                      characterInfo(
                          'Status : ', selectedCharacter.statusIfDeadOrAlive),
                      myDivider(315),
                      characterInfo('Seasons : ',
                          selectedCharacter.appearanceOfSeasons.join(' & ')),
                      myDivider(300),
                      characterInfo('Appeared in : ',
                          selectedCharacter.categoryForTwoSeries),
                      myDivider(270),
                      characterInfo(
                          'Actor/Actress : ', selectedCharacter.actorName),
                      myDivider(250),
                      selectedCharacter.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : characterInfo(
                              'Better Call Saul Seasons : ',
                              selectedCharacter.betterCallSaulAppearance
                                  .join(" & ")),
                      selectedCharacter.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : myDivider(170),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<CharactersCubit, CharactersStates>(
                        builder: (context, state) {
                          return checkIfQuotesAreLoaded(state);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 290,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  //build quotes animated
  Widget checkIfQuotesAreLoaded(CharactersStates state) {
    if (state is QuotesLoadedState) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            color: MYColors.myWhite,
            shadows: [
              Shadow(
                blurRadius: 10,
                color: MYColors.myYellow,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MYColors.myYellow,
      ),
    );
  }
  
}
