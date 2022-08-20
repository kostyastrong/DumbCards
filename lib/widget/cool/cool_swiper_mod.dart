import 'package:flutter/material.dart';
import 'package:flutter_cool_card_swiper/constants.dart';
import 'package:flutter_cool_card_swiper/models/swiper_card.dart';
import 'package:flutter_cool_card_swiper/widgets/swiper_card_item.dart';
import 'package:flutter_cool_card_swiper/widgets/swiper_card_wrapper.dart';
import 'package:current_activity/widget/cool/providers.dart';
import 'package:provider/provider.dart';
import 'package:current_activity/widget/cool/CardActivity.dart';

class CoolSwiperMod extends StatefulWidget {
  List<Widget> children;  // I remove final

  CoolSwiperMod({  // and const here
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  State<CoolSwiperMod> createState() => _CoolSwiperState();
}

class _CoolSwiperState extends State<CoolSwiperMod>
    with SingleTickerProviderStateMixin {
  late final AnimationController backgroundCardsAnimationController;

  late List<Widget> stackChildren;
  final ValueNotifier<bool> flipNotifier = ValueNotifier<bool>(true);
  bool fireBackgroundCardsAnimation = false;

  late final List<SwiperCard> _cards;

  List<Widget> get _stackChildren => List.generate(
    _cards.length,
        (i) {
      return SwiperCardItem(
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

  List<Widget> swapToEnd(List<Widget> prev) {
    List<Widget> ret = prev;
    Widget last = stackChildren[stackChildren.length - 1];
    ret.removeLast();
    ret.insert(0, last);
    int ind = stackChildren.length - 1;
    // for (int i = 0; i < stackChildren.length; ++i) {
    //   context.read<Opaciter>().setOpacity(1 - i * (1 / stackChildren.length));
    // }  // TODO: i don't understand how provider can be applied here
    for (int i = 0; i < prev.length; ++i) {
      ret[ind] = CardActivity(
        key: ValueKey<int> (ind),
        opacity: 1 - i * (1 / stackChildren.length),
      );
      ind -= 1;
    }
    return ret;
  }
  void _swapLast() {

    setState(() {
      stackChildren = swapToEnd(stackChildren);
      debugPrint('yep');
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
        child: SwiperCardWrapper(
          animationController: backgroundCardsAnimationController,
          initialScale: _cards[i].scale,
          initialYOffset: _cards[i].yOffset,
          child: stackChildren[i],
        ),
      ),
    );
  }
}
