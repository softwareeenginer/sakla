import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sakla/view/baseview/view/photo_compress_view.dart';

import '../../view/baseview/view/profile_view.dart';
import '../../view/baseview/view/video_compress_view.dart';

//enum SelectedTab { home, photo, video, myProfile }

class BaseViewConstants {
  static BaseViewConstants? _instance;
  static BaseViewConstants get instance {
    _instance ??= _instance = BaseViewConstants._init();
    return _instance!;
  }

  BaseViewConstants._init();

//this list for battom navigation bar items
  List<BottomNavigationBarItem> get navigationBarItems => [
        /// Photo
        BottomNavigationBarItem(
          icon: Icon(Icons.photo),
        ),

        /// Video
        BottomNavigationBarItem(
          icon: Icon(Icons.video_collection),
        ),

        /// Profile
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
        ),
      ];

  List<Widget> get allPage =>
      [PhotoCompressView(), VideoCompressView(), ProfileView()];
}
