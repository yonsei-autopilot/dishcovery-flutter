import 'package:azlistview/azlistview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/config/theme/color.dart';
import 'package:smart_menu_flutter/src/core/router/router.dart';
import 'package:smart_menu_flutter/src/domain/usecases/pref_usecase.dart';
import 'package:smart_menu_flutter/src/presentation/model/food_suspension_model.dart';
import '../../../notifiers/food_aversion_notifier.dart';

final foodListProvider =
    FutureProvider<List<PrefFoodSuspensionModel>>((ref) async {
  final items = await ref.read(prefUseCaseProvider).getList();
  final models = items.map(PrefFoodSuspensionModel.fromEntity).toList();
  SuspensionUtil.sortListBySuspensionTag(models);
  SuspensionUtil.setShowSuspensionStatus(models);
  return models;
});

class FoodScrollView extends ConsumerStatefulWidget {
  const FoodScrollView({super.key});

  @override
  FoodScrollViewState createState() => FoodScrollViewState();
}

class FoodScrollViewState extends ConsumerState<FoodScrollView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    final aversionsAsync = ref.watch(aversionsProvider);
    final currentAversions = aversionsAsync.value ?? [];

    return FutureBuilder<List<PrefFoodSuspensionModel>>(
      future: ref.read(foodListProvider.future),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          ref.read(routerProvider).go('/user_setting');
        }
        final foodList = snapshot.data!;
        return Container(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xffD9D9D9)),
          height: height * 0.55,
          child: AzListView(
            data: foodList,
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              final foodItem = foodList[index];
              final isSelected = currentAversions.contains(foodItem.name);
              return Column(
                children: [
                  GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(right: 25),
                      decoration: BoxDecoration(
                        color: primaryWhite,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // width: width - 120,
                      height: 38,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 12),
                          BodyText(text: foodList[index].name, size: 14),
                          const Spacer(),
                          if (isSelected)
                            const Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Icon(CupertinoIcons.checkmark_alt, color: Colors.black, size: 20,),
                            )
                        ],
                      ),
                    ),
                    onTap: () {
                      ref.read(aversionsProvider.notifier).addAversion(foodItem.name);
                    },
                  ),
                  if (index != foodList.length - 1) const SizedBox(height: 10),
                ],
              );
            },
            indexBarItemHeight: height * 0.019,
            indexBarWidth: 12.5,
            indexBarData: SuspensionUtil.getTagIndexList(foodList),
            indexBarOptions: const IndexBarOptions(
              needRebuild: true,
              selectTextStyle: TextStyle(
                  color: primaryBlack,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              textStyle: TextStyle(
                  color: primaryGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.normal
              ),
              decoration: BoxDecoration(color: Colors.transparent),
              downDecoration: BoxDecoration(color: Colors.transparent),
              selectItemDecoration: BoxDecoration(color: Colors.transparent),
            ),
            indexHintBuilder: (context, hint) => const SizedBox.shrink(),
            hapticFeedback: true,
          ),
        );
      },
    );
  }
}