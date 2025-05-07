import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/config/theme/color.dart';
import 'package:smart_menu_flutter/src/core/router/router.dart';
import 'package:smart_menu_flutter/src/domain/usecases/pref_usecase.dart';
import 'package:smart_menu_flutter/src/presentation/model/food_suspension_model.dart';

final foodListProvider = FutureProvider<List<PrefFoodSuspensionModel>>((ref) async {
  final items = await ref.read(prefUseCaseProvider).getList('assets/allergens_and_polarizing_foods_sorted.txt');
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
    Size size = MediaQuery
        .of(context)
        .size;
    double height = size.height;

    return FutureBuilder<List<PrefFoodSuspensionModel>>(
      future: ref.read(foodListProvider.future),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          ref.read(routerProvider).go('/user_setting');
        }
        final foodList = snapshot.data!;
        return SizedBox(
          height: height * 0.5,
          child: AzListView(
            data: foodList,
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: BodyText(text: foodList[index].name),
                onTap: () {

                },
              );
            },
            indexBarData: SuspensionUtil.getTagIndexList(foodList),
            indexBarOptions: IndexBarOptions(
                indexHintWidth: 20,
                indexHintHeight: 20,
                indexHintAlignment: Alignment.centerRight,
                downTextStyle: const TextStyle(
                    color: primaryWhite, fontSize: 12),
                downItemDecoration: BoxDecoration(
                    color: primaryGrey,
                    borderRadius: BorderRadius.circular(20)
                )
              ),
            ),
          );
        },
      );
    }
  }