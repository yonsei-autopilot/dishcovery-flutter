import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_menu_flutter/src/presentation/pages/menu_order/menu_order_page.dart';
import '../../../../config/theme/body_text.dart';
import '../../../../config/theme/color.dart';
import '../../../../domain/dtos/menu/menu_order_response.dart';

class OrderDefaultWidget extends ConsumerStatefulWidget {
  final MenuOrderResponse response;
  final MenuOrderPageParams params;

  const OrderDefaultWidget({super.key, required this.response, required this.params});

  @override
  OrderDefaultWidgetState createState() => OrderDefaultWidgetState();
}

class OrderDefaultWidgetState extends ConsumerState<OrderDefaultWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;

    return Stack(
      children: [
        Positioned(
            top: 75,
            left: 35,
            child: GestureDetector(
              child: const Icon(
                CupertinoIcons.arrow_left,
                size: 30,
                color: primaryBlack,
              ),
              onTap: () {
                context.pop();
              },
            )),
        const Positioned(
          top: 75,
          left: 0,
          right: 0,
          child: Center(
              child: BodyText(
            text: 'Order',
            size: 20,
            color: primaryBlack,
          )),
        ),
        // circle
        Positioned(
          top: 175,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 8,
                        color: primaryBlack)
                  ]),
              child: CircleAvatar(
                radius: 75,
                backgroundColor: mainColor,
                child: const CircleAvatar(
                  radius: 65,
                  backgroundColor: primaryLightGreen,
                  child: Icon(
                    CupertinoIcons.mic,
                    size: 55,
                    color: primaryBlack,
                  ),
                ),
              ),
            ),
          ),
        ),
        // order card (first)
        Positioned(
          bottom: 240,
          left: 25,
          right: 25,
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 10),
            width: width - 50,
            height: 160,
            decoration: BoxDecoration(
                color: const Color(0xffD9D9D9),
                borderRadius: BorderRadius.circular(17),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 6, color: primaryGrey, offset: Offset(1, 2))
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    width: width - 175,
                    child: BodyText(
                      text: widget.response.orderInUserLanguage,
                      size: 14,
                      overflow: TextOverflow.ellipsis,
                      maxLine: 5,
                    )
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      ref.read(pageIndexProvider.notifier).state = 1;
                    },
                    child: Container(
                      width: 85,
                      height: 135,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: mainColor,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 5,
                            offset: Offset(0, 3),
                            color: primaryGrey
                          )
                        ]
                      ),
                      child: const Center(child: BodyText(text: 'Request', size: 14, color: primaryWhite,)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        // check card (second)
        Positioned(
          bottom: 50,
          left: 25,
          right: 25,
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 10),
            width: width - 50,
            height: 160,
            decoration: BoxDecoration(
                color: const Color(0xffD9D9D9),
                borderRadius: BorderRadius.circular(17),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 6, color: primaryGrey, offset: Offset(1, 2))
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    width: width - 175,
                    child: BodyText(
                      text: widget.response.inquiryForDislikeFoodsInUserLanguage,
                      size: 14,
                      overflow: TextOverflow.ellipsis,
                      maxLine: 5,
                    )
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      ref.read(pageIndexProvider.notifier).state = 2;
                    },
                    child: Container(
                      width: 85,
                      height: 135,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: mainColor,
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 5,
                                offset: Offset(0, 3),
                                color: primaryGrey
                            )
                          ]
                      ),
                      child: const Center(child: BodyText(text: 'Request', size: 14, color: primaryWhite,)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
