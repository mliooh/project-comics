import 'package:flutter/material.dart';
import 'package:project_comics/pages/SearchPage.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.yellow,
      unselectedItemColor: const Color.fromARGB(255, 227, 224, 197),
      backgroundColor: Colors.grey.shade900,
      iconSize: 33,
      items: [
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.home,
                )),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchPage()));
                },
                icon: const Icon(
                  Icons.search,
                )),
            label: 'Search'),
      ],
    );
  }
}
