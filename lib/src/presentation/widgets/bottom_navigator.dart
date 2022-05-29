import 'package:flutter/material.dart';
import 'package:testproject/src/presentation/views/calendar_screen.dart';
import 'package:testproject/src/presentation/views/home_screen.dart';

class MyAppBottomNavigator extends StatelessWidget {
  const MyAppBottomNavigator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BottomNavigatorView();
  }
}

class BottomNavigatorView extends StatefulWidget {
  const BottomNavigatorView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomNavigatorViewState();
}

class _BottomNavigatorViewState extends State<BottomNavigatorView> {
  int selectedIndex = 0;
  late PageController controller;
  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [HomeScreen(), CalendarScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: ((value) {
          setState(() {
            selectedIndex = value;
          });
          controller.animateToPage(
            selectedIndex,
            duration: const Duration(microseconds: 300),
            curve: Curves.easeIn,
          );
        }),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
        ],
      ),
    );
  }
}
