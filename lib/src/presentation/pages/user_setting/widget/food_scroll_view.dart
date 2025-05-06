import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodScrollView extends ConsumerStatefulWidget {
  const FoodScrollView({super.key});

  @override
  FoodScrollViewState createState() => FoodScrollViewState();
}

class FoodScrollViewState extends ConsumerState<FoodScrollView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;

    // return AlphabetScrollView(
    //     list: list,
    //     selectedTextStyle: selectedTextStyle,
    //     unselectedTextStyle: unselectedTextStyle,
    //     itemBuilder: itemBuilder
    // );
    return Placeholder();
  }
}
