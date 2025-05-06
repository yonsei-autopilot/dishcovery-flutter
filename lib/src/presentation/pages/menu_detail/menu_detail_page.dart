import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/config/theme/color.dart';

typedef MenuDetailPageParams = ({
  String imageUrl,
  String menuName,
  String menuDescription,
  String foodAversion
});

class MenuDetailPage extends ConsumerStatefulWidget {
  const MenuDetailPage({super.key, required this.params});
  final MenuDetailPageParams params;

  @override
  MenuDetailPageState createState() => MenuDetailPageState();
}

class MenuDetailPageState extends ConsumerState<MenuDetailPage> {
  @override
  Widget build(BuildContext context) {
    // UI 수정 필요
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(35, 75, 35, 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: const Icon(
                    CupertinoIcons.arrow_left,
                    size: 30,
                    color: primaryBlack,
                  ),
                  onTap: () {
                    context.pop();
                  },
                ),
                const SizedBox(height: 5,),
                Center(child: Image.network(widget.params.imageUrl, width: 135, height: 135, fit: BoxFit.fitHeight,)),
                const SizedBox(height: 35,),
                BodyText(text: widget.params.menuName, size: 20,),
                const SizedBox(height: 5,),
                BodyText(text: widget.params.menuDescription, size: 20,),
                const SizedBox(height: 5,),
                BodyText(text: widget.params.foodAversion, size: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
