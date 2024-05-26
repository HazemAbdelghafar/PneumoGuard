import 'package:flutter/material.dart';

ValueNotifier<int> navbarIndex = ValueNotifier<int>(0);

class myBottomBar extends StatelessWidget {
  final int currentIndex;

  const myBottomBar({super.key, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: navbarIndex,
      builder: (context, value, child) {
        return BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              navbarIndex.value = index;
              switch (index) {
                case 0:
                  Navigator.pushNamed(context, '/');
                  break;
                case 1:
                  Navigator.pushNamed(context, '/detection');
                  break;
                case 2:
                  Navigator.pushNamed(context, '/profile');
                  break;
              }
            },
            selectedFontSize: 0,
            unselectedFontSize: 0,
            iconSize: 30,
            elevation: 5,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: const Color(0xFF7AA2E3),
            unselectedItemColor: const Color(0xFF97E7E1),
            backgroundColor: const Color(0xFFF8F6E3),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "",
              )
            ]);
      },
    );
  }
}
