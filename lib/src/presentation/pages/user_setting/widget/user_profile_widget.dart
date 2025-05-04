import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/config/theme/color.dart';

class UserProfileWidget extends ConsumerStatefulWidget {
  const UserProfileWidget({super.key});

  @override
  UserProfileWidgetState createState() => UserProfileWidgetState();
}

class UserProfileWidgetState extends ConsumerState<UserProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          const SizedBox(width: 57,),
          Image.asset(
            'assets/images/profile.png',
            width: 80,
            height: 80,
          ),
          const SizedBox(
            width: 25,
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyText(
                text: 'Autopilot',
                size: 14,
                color: primaryBlack,
              ),
              SizedBox(
                height: 6,
              ),
              BodyText(
                text: 'autopilot@yonsei.ac.kr',
                size: 14,
                color: primaryBlack,
              ),
            ],
          )
        ],
      ),
    );
  }
}
