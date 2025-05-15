import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marqueer/marqueer.dart';
import 'package:smart_menu_flutter/src/presentation/pages/menu_order/menu_order_page.dart';
import '../../../config/theme/body_text.dart';
import '../../../config/theme/color.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/router.dart';
import '../../../domain/entities/cart_item.dart';
import '../../notifiers/cart_notifier.dart';

class MenuCartPage extends ConsumerStatefulWidget {
  const MenuCartPage({super.key});

  @override
  MenuCartPageState createState() => MenuCartPageState();
}

class MenuCartPageState extends ConsumerState<MenuCartPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final notifier = ref.read(cartProvider.notifier);
      await notifier.loadCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: primaryWhite,
      body: Stack(
        children: [
          // appbar
          Positioned(
            top: 75,
            left: 25,
            right: 25,
            child: Stack(
              children: [
                const Center(
                  child: BodyText(
                    text: 'Your Menus',
                    size: 20,
                    color: primaryBlack,
                  ),
                ),
                Positioned(
                  left: 10,
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(
                      CupertinoIcons.arrow_left,
                      size: 30,
                      color: primaryBlack,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 125,
            left: 0,
            right: 0,
            bottom: 0,
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10, bottom: 120),
              itemCount: cartItems.length,
              itemBuilder: (context, i) {
                final item = cartItems[i];
                return Container(
                  margin: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  width: width - 60,
                  height: 170,
                  decoration: BoxDecoration(
                      color: const Color(0xffE9E9E9),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2.5,
                            blurRadius: 3,
                            offset: const Offset(0, 2))
                      ]),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: width - 170,
                            height: 25,
                            child: Marqueer(
                              pps: 15,
                              direction: MarqueerDirection.rtl,
                              infinity: false,
                              edgeDuration: const Duration(seconds: 1),
                              child: BodyText(
                                text: item.menuName,
                                size: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Image.network(
                            item.imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Spacer(),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        child: const BodyText(
                                          text: 'View Details',
                                          size: 16,
                                          color: Color(0xff006FFF),
                                        ),
                                        onTap: () {
                                          ref.read(routerProvider).push(
                                              '/menu_detail',
                                              extra: (menuName: item.menuName, availableOptions: item.availableOptions));
                                        },
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        child: const Icon(
                                          Icons.remove,
                                          size: 12,
                                        ),
                                        onTap: () {
                                          if (item.count > 1) {
                                            ref
                                                .read(cartProvider.notifier)
                                                .addOrUpdateItem(
                                                  item.copyWith(
                                                      count: item.count - 1),
                                                );
                                          } else {
                                            ref
                                                .read(cartProvider.notifier)
                                                .removeItem(item.menuName);
                                          }
                                        },
                                      ),
                                      const SizedBox(width: 8),
                                      BodyText(
                                        text: item.count.toString(),
                                        size: 12,
                                      ),
                                      const SizedBox(width: 8),
                                      GestureDetector(
                                        child: const Icon(
                                          Icons.add,
                                          size: 12,
                                        ),
                                        onTap: () {
                                          ref
                                              .read(cartProvider.notifier)
                                              .addOrUpdateItem(
                                                item.copyWith(
                                                    count: item.count + 1),
                                              );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          // order button
          Positioned(
            bottom: 45,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3))
                      ]),
                  child: const Center(
                      child: BodyText(
                    text: 'Order',
                    color: primaryWhite,
                    size: 14,
                  )),
                ),
                onTap: () {
                  final details = cartItems
                      .map((item) => (
                            name: item.menuName,
                            count: item.count.toString(),
                            description: '',
                          ))
                      .toList();
                  final params = (menuOrderDetailParams: details,);
                  ref.read(pageIndexProvider.notifier).state = 0;
                  ref.read(routerProvider).push(
                        '/menu_order',
                        extra: params,
                      );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
