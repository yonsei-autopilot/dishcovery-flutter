import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/config/theme/color.dart';
import 'package:smart_menu_flutter/src/data/local/shared_preferences_provider.dart';

import '../../../../domain/entities/user.dart';

class UserProfileWidget extends ConsumerStatefulWidget {
  const UserProfileWidget({super.key});

  @override
  UserProfileWidgetState createState() => UserProfileWidgetState();
}

class UserProfileWidgetState extends ConsumerState<UserProfileWidget> {
  @override
  Widget build(BuildContext context) {
    final userJson = ref.read(sharedPreferencesProvider).getString('user');
    User? user;
    if (userJson != null) {
      user = User.fromJson(jsonDecode(userJson));
    } else {
      user = null;
    }

    return Center(
      child: Row(
        children: [
          (user == null || user.imageUrl == null) ?
          Image.asset(
            'assets/images/profile.png',
            width: 55,
            height: 55,
          ) : CircleAvatar(
            radius: 27.5,
            backgroundImage: NetworkImage(user.imageUrl!),
          ),
          const SizedBox(
            width: 25,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyText(
                text: (user == null || user.id == null) ? 'Unknown' : user.id!,
                size: 20,
                color: primaryBlack,
              ),
              const SizedBox(
                height: 7,
              ),
              BodyText(
                text: (user == null || user.email == null) ? 'Unknown' : user.email!,
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
