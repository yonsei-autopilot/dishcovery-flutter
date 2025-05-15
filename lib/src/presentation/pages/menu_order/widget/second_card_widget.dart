import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_menu_flutter/src/presentation/pages/menu_order/menu_order_page.dart';
import '../../../../config/theme/body_text.dart';
import '../../../../config/theme/color.dart';
import '../../../../data/local/shared_preferences_provider.dart';
import '../../../../domain/dtos/menu/menu_order_response.dart';
import '../../../notifiers/menu_order_notifier.dart';

class OrderSecondCardWidget extends ConsumerStatefulWidget {
  final MenuOrderResponse response;
  final MenuOrderPageParams params;
  const OrderSecondCardWidget({super.key, required this.response, required this.params});

  @override
  OrderSecondCardWidgetState createState() => OrderSecondCardWidgetState();
}

class OrderSecondCardWidgetState extends ConsumerState<OrderSecondCardWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    ref.read(menuOrderNotifierProvider(widget.params).notifier).playInquiryAudio();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    final lang = ref.read(sharedPreferencesProvider).get('language');

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
          top: height * 0.2,
          left: 0,
          right: 0,
          child: Center(
            child: Column(
              children: [
                Container(
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
                    radius: width*0.15,
                    backgroundColor: primaryLightGreen,
                    child: CircleAvatar(
                      radius: (width*0.15)+10,
                      backgroundColor: primaryGreen,
                      child: const Icon(
                        CupertinoIcons.mic,
                        size: 55,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 35,),
                const BodyText(
                  text: 'Tap to play again',
                  size: 16,
                  color: Color(0xff8C8C8C),
                ),
              ],
            ),
          ),
        ),
        // first card
        Positioned(
          bottom: height * 0.03,
          left: 0,
          right: 0,
          child: Column(
            children: [
              // first card
              Center(
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  width: width-55,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: const Color(0xffD9D9D9),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 3,
                            offset: Offset(0, 2),
                            color: primaryGrey
                        )
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width - 220,
                        child: BodyText(
                          text: widget.response.inquiryForDislikeFoodsInUserLanguage,
                          maxLine: 1,
                          overflow: TextOverflow.ellipsis,
                          size: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ref.read(pageIndexProvider.notifier).state = 1;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: mainColor,
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                    color: primaryGrey
                                )
                              ]
                          ),
                          width: 85,
                          height: 35,
                          child: const Center(child: BodyText(text: 'Request', size: 14, color: primaryWhite,)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              // second card
              GestureDetector(
                onTap: () {
                  ref.read(menuOrderNotifierProvider(widget.params).notifier).playInquiryAudio();
                },
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.only(right: 12),
                    width: width - 55,
                    height: height * 0.37,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                        color: const Color(0xffD9D9D9),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 3,
                              offset: Offset(0, 2),
                              color: primaryGrey)
                        ]),
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      radius: const Radius.circular(8),
                      thickness: 3,
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(30, 30, 18, 30),
                        controller: _scrollController,
                        children: [
                          BodyText(text: widget.response.inquiryForDislikeFoodsInUserLanguage, size: 20, color: primaryBlack,),
                          const SizedBox(height: 20,),
                          const Divider(color: Color(0xff8C8C8C),),
                          const SizedBox(height: 20,),
                          BodyText(text: widget.response.inquiryForDislikeFoodsInForeignLanguage, size: 28, color: primaryBlack,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
