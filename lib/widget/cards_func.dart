import 'package:flutter/material.dart';
import 'package:swipe/swipe.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';
import 'dart:math' as math;

Color ColorOfWord(String s) {
  return Color(s.hashCode % 16777215).withOpacity(1.0);
}

void removeTopActivity(List<String> ref) {
  ref.removeAt(0);
}

void delayActivity(List<String> ref) {
  ref.add(ref.first);
  removeTopActivity(ref);
}

Card cardByWord(BuildContext context, String word) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return Card(
      color: ColorOfWord(word),
      //Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
      child: Container(
        width: width * 0.7,
        height: height * 0.7,
        child: Center(
          child: Text(
            word,
            style: TextStyle(
              fontFamily: 'Arial',
              fontSize: 18,
              color: Colors.white,
              height: 1,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ));
}