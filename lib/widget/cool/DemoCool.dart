import 'package:flutter/material.dart';
import 'package:flutter_cool_card_swiper/constants.dart';
import 'package:flutter_cool_card_swiper/data.dart';
import 'package:flutter_cool_card_swiper/widgets/cool_swiper.dart';
import 'package:swipe/swipe.dart';

Color ColorOfWord(String s) {
  return Color(s.hashCode % 16777215).withOpacity(1.0);
}

List<String> words = List<String>.generate(7, (index) => index.toString());
List<Color> colors = List<Color>.generate(words.length, (index) => ColorOfWord(words[index]));

class DemoCool extends StatelessWidget {
  const DemoCool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(colors.length.toString());
    return Scaffold(
      backgroundColor: Colors.black,
      body: Swipe(
        onSwipeDown: debugPrint('down'),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: CoolSwiper(
              children: List.generate(
                colors.length,
                    (index) => Container(
                  height: Constants.cardHeight,
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 15,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 15,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}