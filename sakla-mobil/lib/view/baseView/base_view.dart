import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import '../../core/constants/base_view_constants.dart';

class BaseView extends StatefulWidget {
  @override
  _BaseViewState createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  late PageController pageController;
  final snakeShape = SnakeShape.rectangle;

  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BaseViewConstants.instance.allPage[selectedIndex],
        bottomNavigationBar: buildSnakeNavigationBar(context));
  }

  Widget buildSnakeNavigationBar(BuildContext context) {
    return SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.pinned,
        snakeShape: SnakeShape.rectangle,
        snakeViewColor: Color(0xff252880),
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? Colors.white : null,
        unselectedItemColor: Colors.grey[800],
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => {selectedIndex = index}),
        items: BaseViewConstants.instance.navigationBarItems);
  }

  // Widget buildPageViewBody() {
  //   return PageView(
  //     controller: pageController,
  //     onPageChanged: (int index) {
  //       setState(() {
  //         selectedIndex = index;
  //         _handleIndexChanged(index);
  //       });
  //     },
  //     children: BaseViewConstants.instance.allPage,
  //   );
  // }

  // void _handleIndexChanged(int i) {
  //   setState(() {
  //     pageController.jumpToPage(i);
  //     _selectedTab = SelectedTab.values[i];
  //   });
  // }
}
