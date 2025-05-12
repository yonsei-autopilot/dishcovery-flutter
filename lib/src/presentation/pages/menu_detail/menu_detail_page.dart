import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/presentation/notifiers/menu_detail_notifier.dart';
import 'package:smart_menu_flutter/src/config/theme/color.dart';

typedef MenuDetailPageParams = ({
  String menuName,
});

class MenuDetailPage extends ConsumerStatefulWidget {
  final MenuDetailPageParams params;
  const MenuDetailPage({super.key, required this.params});

  @override
  ConsumerState<MenuDetailPage> createState() => _MenuDetailPageState();
}

class _MenuDetailPageState extends ConsumerState<MenuDetailPage> {
  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(menuDetailNotifierProvider(widget.params));

    return detailAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar:
            AppBar(leading: const BackButton(), title: const Text('Details')),
        body: Center(child: Text('Error: $e')),
      ),
      data: (detail) {
        return Scaffold(
          backgroundColor: primaryWhite,
          body: Stack(
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
                      text: 'Details',
                      size: 20,
                      color: primaryBlack,
                    )),
              ),
              Positioned(
                top: 135,
                left: 0,
                right: 0,
                bottom: 0,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: BodyText(
                          text: detail.name,
                          size: 20,
                          weight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Image carousel
                      SizedBox(
                        height: 200,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: detail.imageLinks.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 12),
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: EdgeInsets.only(left: i == 0 ? 40 : 0, right: i == detail.imageLinks.length-1 ? 40 : 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  detail.imageLinks[i],
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Description
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BodyText(
                              text: detail.description,
                              size: 14,
                            ),
                            const SizedBox(height: 25),
                            const Divider(),
                            const SizedBox(height: 25),
                            // Ingredients
                            const BodyText(
                              text: 'Ingredients Included',
                              weight: FontWeight.bold,
                              size: 15,
                            ),
                            const SizedBox(height: 15),
                            BodyText(
                              text: detail.ingredients,
                              size: 14,
                            ),
                            const SizedBox(height: 35),

                            // Watch Out
                            const Row(
                              children: [
                                Icon(Icons.info_outline, size: 25,),
                                SizedBox(width: 8),
                                BodyText(
                                  text: 'Watch Out',
                                  weight: FontWeight.bold,
                                  size: 15,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            BodyText(
                              text: detail.whatToBeCareful,
                              size: 14,
                            ),
                            const SizedBox(height: 25),

                            // Count selector (static)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {},
                                ),
                                const SizedBox(width: 8),
                                const BodyText(text: '1', size: 16,),
                                const SizedBox(width: 8),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            const SizedBox(height: 120),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                            text: 'Add to Cart',
                            color: primaryWhite,
                            size: 14,
                          )),
                    ),
                    onTap: () async {

                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
