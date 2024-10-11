import 'package:flutter/material.dart';

class HotScreen extends StatelessWidget {
  const HotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('New & Hot'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.cast),
            ),
            const SizedBox(width: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                color: Colors.blue,
                height: 25,
                width: 25,
              ),
            ),
            const SizedBox(width: 16),
          ],
          bottom: TabBar(
         dividerColor: Colors.black,
          labelColor: Colors.black,
          indicatorColor: Colors.white,
          unselectedLabelColor: Colors.white,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Colors.white),

          tabs: [
            Tab(
              text: ' 🍿 Coming Soon  ',
            ),
            Tab(
              text: " 🔥 Everyone's watching   ",
            )
          ],
        ),
      ),
    ),);
  }
}
