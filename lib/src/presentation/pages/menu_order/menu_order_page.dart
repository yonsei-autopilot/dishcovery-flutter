import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/presentation/notifiers/menu_order_notifier.dart';
import 'package:smart_menu_flutter/src/presentation/pages/menu_order/widget/default_widget.dart';
import 'package:smart_menu_flutter/src/presentation/pages/menu_order/widget/first_card_widget.dart';
import 'package:smart_menu_flutter/src/presentation/pages/menu_order/widget/second_card_widget.dart';
import '../../../config/theme/color.dart';
import '../../../domain/dtos/menu/menu_order_response.dart';

typedef MenuOrderDetailParams = ({
  String name,
  String count,
  String description
});

typedef MenuOrderPageParams = ({
  List<MenuOrderDetailParams> menuOrderDetailParams
});

final pageIndexProvider = StateProvider<int>((ref) => 0);

class MenuOrderPage extends ConsumerStatefulWidget {
  const MenuOrderPage({super.key, required this.params});

  final MenuOrderPageParams params;

  @override
  MenuOrderPageState createState() => MenuOrderPageState();
}

class MenuOrderPageState extends ConsumerState<MenuOrderPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final orderAsync = ref.watch(menuOrderNotifierProvider(widget.params));
    final currentPage = ref.watch(pageIndexProvider);

    return orderAsync.when(
      loading: () => Scaffold(
        backgroundColor: primaryWhite,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: mainColor,
            ),
            const SizedBox(
              height: 15,
            ),
            BodyText(
              text: 'Generating Audio...',
              color: mainColor,
            )
          ],
        )),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(leading: const BackButton(), title: const Text('Order')),
        body: Center(child: Text('Error: $e')),
      ),
      data: (resp) {
        return Scaffold(
          backgroundColor: primaryWhite,
          body: _buildPage(currentPage, resp, widget.params)
        );
      },
    );
  }

  Widget _buildPage(int index, MenuOrderResponse res, MenuOrderPageParams params) {
    switch (index) {
      case 1:
        return OrderFirstCardWidget(response: res, params: params);
      case 2:
        return OrderSecondCardWidget(response: res, params: params);
      default:
        return OrderDefaultWidget(response: res, params: params,);
    }
  }
}
