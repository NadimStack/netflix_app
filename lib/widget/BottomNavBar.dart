import 'package:flutter/material.dart';
import 'package:netflix_app/screen/HomeScreen.dart';
import 'package:netflix_app/screen/SearchBar.dart';
import 'package:netflix_app/screen/new&hotScreen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          indicatorColor: Colors.transparent,
          tabs: [
            Tab(
              text: 'Home',
              icon: Icon(Icons.home),
            ),
            Tab(
              text: 'Serach',
              icon: Icon(Icons.search),
            ),
            Tab(
              text: 'New & Hot',
              icon: Icon(Icons.photo_library_outlined),
            ),
          ],
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
        ),
        body: TabBarView(children: [HomeScreen(), SearchScreen(), HotScreen()]),
      ),
    );
  }
}
