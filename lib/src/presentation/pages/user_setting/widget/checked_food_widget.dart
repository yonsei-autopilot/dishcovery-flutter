import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/config/theme/color.dart';
import '../../../notifiers/food_aversion_notifier.dart';

class CheckedFoodWidget extends ConsumerStatefulWidget {
  const CheckedFoodWidget({super.key});

  @override
  CheckedFoodWidgetState createState() => CheckedFoodWidgetState();
}

class CheckedFoodWidgetState extends ConsumerState<CheckedFoodWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aversionsAsync = ref.watch(aversionsProvider);
    final Size size = MediaQuery.of(context).size;
    double height = size.height;

    return aversionsAsync.when(
      loading: () => const SizedBox(
        height: 50,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => SizedBox(
        height: 50,
        child: Center(child: Text('에러: $err')),
      ),
      data: (checkedItems) {
        if (checkedItems.isEmpty) {
          return const SizedBox();
        } else {
          return Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            trackVisibility: false,
            radius: const Radius.circular(8),
            thickness: 3,
            child: SizedBox(
              height: 55,
              child: ListView.separated(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(bottom: 13, left: 4, right: 6),
                itemCount: checkedItems.length,
                itemBuilder: (context, index) {
                  final item = checkedItems[index];
                  return GestureDetector(
                    onTap: () {
                      ref.read(aversionsProvider.notifier).removeAversion(item);
                    },
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: height * 0.053,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: primaryLightGreen,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(1,2),
                              blurRadius: 5,
                              color: Color(0xffC8C8C8)
                            )
                          ]
                        ),
                        child: Row(
                          children: [
                            BodyText(text: item, size: 15),
                            const SizedBox(width: 8),
                            const Icon(CupertinoIcons.clear, color: primaryGrey, size: 16),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 18),
              ),
            ),
          );
        }
      },
    );
  }
}
