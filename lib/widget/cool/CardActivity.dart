import 'package:flutter/material.dart';
import 'package:flutter_cool_card_swiper/constants.dart';



class CardActivity extends StatefulWidget {
  CardActivity({Key? key, required double this.opacity}) : super(key: key);
  double opacity;

  @override
  State<CardActivity> createState() => _CardState();
}

class _CardState extends State<CardActivity> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.cardHeight,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.redAccent.shade700.withOpacity(widget.opacity),
        border: Border.all(
          color: Colors.yellow.withOpacity(widget.opacity),
          width: 3,
        ),
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
    );
  }
}