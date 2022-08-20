import 'package:flutter/material.dart';
import 'package:flutter_cool_card_swiper/constants.dart';
import 'package:flutter_cool_card_swiper/data.dart';
import 'package:flutter_cool_card_swiper/widgets/cool_swiper.dart';
import 'package:provider/provider.dart';
import 'package:swipe/swipe.dart';
import 'package:current_activity/widget/cool/CardActivity.dart';
import 'cool_swiper_mod.dart';

Color ColorOfWord(String s) {
  return Color(s.hashCode % 16777215).withOpacity(1.0);
}

List<Color> makeGradient(int num, Color start, [Color finish = Colors.black]) {
  return [Colors.black];
}

List<String> words = List<String>.generate(13, (index) => index.toString());
List<Color> colors =
    List<Color>.generate(words.length, (index) => ColorOfWord(words[index]));

class DemoCool extends StatelessWidget {
  const DemoCool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(colors.length.toString());
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: CoolSwiperMod(
                children: List.generate(
                    colors.length,
                    (index) => CardActivity(
                          key: ValueKey<int>(index),
                          opacity: 1 - index * (1 / words.length),
                        )),
              ),
            ),
          ),
    );
  }
}


