import 'package:flutter/material.dart';
import 'package:swipe/swipe.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';
import 'package:current_activity/widget/cards_func.dart';
import 'dart:math' as math;


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> curActivities = ['1', '2', '3'];

  @override
  Widget build(BuildContext context) {
    debugPrint("newBuild");
    SwipingCardDeck deck = SwipingCardDeck(
      cardDeck: getCardDeck(),
      onDeckEmpty: () {
        debugPrint("Card deck empty");
      },
      onLeftSwipe: (Card card) {
        debugPrint("Swiped left!");
        delayActivity(curActivities);
        },
      onRightSwipe: (Card card) {
        debugPrint("Swiped right!");
        removeTopActivity(curActivities);
      },
      cardWidth: 200,
      swipeThreshold: MediaQuery.of(context).size.width / 3,
      minimumVelocity: 1000,
      rotationFactor: 0.8 / 3.14,
      swipeAnimationDuration: const Duration(milliseconds: 500),
    );
    return Swipe(
      onSwipeDown: () => debugPrint("swipped down, mthfck"),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          deck,
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.clear),
                  iconSize: 30,
                  color: Colors.red,
                  onPressed: deck.animationActive ? null : () => deck.swipeLeft(),
                ),
                const SizedBox(width: 40),
                IconButton(
                  icon: const Icon(Icons.check),
                  iconSize: 30,
                  color: Colors.green,
                  onPressed: deck.animationActive ? null : () => deck.swipeRight(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Card> getCardDeck() {
    List<Card> cardDeck = [];
    for (final i in curActivities) {
      cardDeck.add(cardByWord(context, i));
    }
    return cardDeck;
  }
}
