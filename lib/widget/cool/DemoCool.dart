import 'package:current_activity/widget/cool/card_item.dart';
import 'package:current_activity/widget/cool/swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cool_card_swiper/constants.dart';
import 'package:flutter_cool_card_swiper/data.dart';
import 'package:flutter_cool_card_swiper/widgets/cool_swiper.dart';
import 'package:provider/provider.dart';
import 'package:swipe/swipe.dart';
import 'package:current_activity/widget/cool/CardActivity.dart';
import 'cool_swiper_mod.dart';
import 'package:blurrycontainer/blurrycontainer.dart';

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
      backgroundColor: const Color(0xFF11262d),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(children: [
            Swiper(
              children: List.generate(
                  colors.length,
                  (index) => CardActivity(
                        key: ValueKey<int>(index),
                        opacity: 1,
                      )),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlurryContainer(
                color: Colors.white.withOpacity(0.15),
                blur: 8,
                elevation: 6,
                height: 350,
                padding: const EdgeInsets.all(32),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "You are doing:".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Center(
                      child: Text(
                        "STATE MANAGEMENT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "additional info".toUpperCase(),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            // fontSize: 16,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "Expiring:",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "Today",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
