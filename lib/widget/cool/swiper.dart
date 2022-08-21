import 'package:current_activity/widget/cool/CardActivity.dart';
import 'package:current_activity/widget/cool/DemoCool.dart';
import 'package:current_activity/widget/cool/card_item.dart';
import 'package:current_activity/widget/cool/card_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cool_card_swiper/constants.dart';
import 'package:flutter_cool_card_swiper/models/swiper_card.dart';
import 'package:flutter_cool_card_swiper/widgets/swiper_card_item.dart';
import 'package:flutter_cool_card_swiper/widgets/swiper_card_wrapper.dart';

class Swiper extends StatefulWidget {
  final List<Widget> children;

  const Swiper({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  State<Swiper> createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> with SingleTickerProviderStateMixin {
  late final AnimationController backgroundCardsAnimationController;

  late final List<CardItem> stackChildren;
  final ValueNotifier<bool> flipNotifier = ValueNotifier<bool>(true);
  bool fireBackgroundCardsAnimation = false;

  late final List<SwiperCard> _cards;

  List<CardItem> get _stackChildren => List.generate(
        _cards.length,
        (i) {
          return CardItem(
            key: ValueKey('__animated_card_${i}__'),
            card: _cards[i],
            onAnimationTrigger: _onAnimationTrigger,
            onVerticalDragEnd: () {},
          );
        },
      );

  void _onAnimationTrigger() async {
    setState(() {
      fireBackgroundCardsAnimation = true;
    });
    backgroundCardsAnimationController.forward();
    Future.delayed(Constants.backgroundCardsAnimationDuration).then(
      (_) {
        flipNotifier.value = false;
      },
    );
    Future.delayed(Constants.swipeAnimationDuration).then(
      (_) {
        flipNotifier.value = true;
        backgroundCardsAnimationController.reset();
        _swapLast();
      },
    );
  }

  void _swapLast() {
    CardItem last = stackChildren[stackChildren.length - 1];
    setState(() {
      stackChildren.removeLast();
      stackChildren.insert(0, last);
    });
  }

  @override
  void initState() {
    super.initState();
    _cards = SwiperCard.listFromWidgets(widget.children);
    stackChildren = _stackChildren;

    backgroundCardsAnimationController = AnimationController(
      vsync: this,
      duration: Constants.backgroundCardsAnimationDuration,
    );
  }

  @override
  void dispose() {
    backgroundCardsAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder(
          valueListenable: flipNotifier,
          builder: (c, bool flip, _) => flip
              ? _buildBackgroundCardsStack()
              : Positioned(child: Container()),
        ),
        _buildFrontCard(),
        ValueListenableBuilder(
          valueListenable: flipNotifier,
          builder: (c, bool flip, _) => flip
              ? Positioned(child: Container())
              : _buildBackgroundCardsStack(),
        ),
      ],
    );
  }

  Widget _buildBackgroundCardsStack() {
    return Stack(
      children: List.generate(
        _cards.length - 1,
        (i) => _buildStackChild(i),
      ),
    );
  }

  Widget _buildFrontCard() {
    return _buildStackChild(_cards.length - 1);
  }

  Widget _buildStackChild(int i) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: IgnorePointer(
        ignoring: i != stackChildren.length - 1,
        child: CardWrapper(
          animationController: backgroundCardsAnimationController,
          initialScale: _cards[i].scale,
          initialYOffset: _cards[i].yOffset,
          child: stackChildren[i],
        ),
      ),
    );
  }
}
