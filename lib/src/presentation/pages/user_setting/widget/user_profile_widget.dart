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
          Image.asset(
            'assets/images/profile.png',
            width: 55,
            height: 55,
          ),
          const SizedBox(
            width: 25,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyText(
                text: 'Autopilot',
                size: 20,
                color: primaryBlack,
              ),
              SizedBox(
                height: 15,
              ),
              BodyText(
                text: 'autopilot@yonsei.ac.kr',
                size: 12,
                color: primaryBlack,
              ),
            ],
          )
        ],
      ),
    );
  }
}
