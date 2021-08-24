import 'package:flutter/material.dart';

import '../../../core/components/profile_app_bar_container.dart';
import '../../../core/extension/context_extension.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildProfileAppBar(),
          SizedBox(
            height: context.height / 5,
          ),
          Container()
        ],
      ),
    );
  }

  ProfileAppBar buildProfileAppBar() {
    return ProfileAppBar(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.person,
          color: Colors.white,
          size: 50,
        ),
        Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontSize: 25),
        )
      ],
    ));
  }
}
