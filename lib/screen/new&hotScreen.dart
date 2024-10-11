import 'package:flutter/material.dart';
import '../widget/comingSoon_movie_card.dart';

class HotScreen extends StatelessWidget {
  const HotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'New & Hot',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
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
            labelStyle: const TextStyle(fontWeight: FontWeight.w700),
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.white,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            tabs: const [
              Tab(text: ' 🍿 Coming Soon  '),
              Tab(text: " 🔥 Everyone's watching   "),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // First Tab (Coming Soon)
            SingleChildScrollView(
              child: Column(
                children: [
                  ComingSoonMovieCard(
                    imgUrl:
                        'https://miro.medium.com/v2/resize:fit:1024/1*P_YU8dGinbCy6GHlgq5OQA.jpeg',
                    logoUrl:
                        'https://s3.amazonaws.com/www-inside-design/uploads/2017/10/strangerthings_feature-983x740.jpg',
                    day: '28',
                    month: 'June',
                    overView:
                        'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
                  ),
                  ComingSoonMovieCard(
                    imgUrl:
                        'https://www.pinkvilla.com/images/2022-09/rrr-review.jpg',
                    logoUrl:
                        'https://www.careerguide.com/career/wp-content/uploads/2023/10/RRR_full_form-1024x576.jpg',
                    day: '27',
                    month: 'june',
                    overView:
                        'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
                  ),
                ],
              ),
            ),

            // Second Tab (Everyone's Watching)
            ComingSoonMovieCard(
              imgUrl: 'https://www.pinkvilla.com/images/2022-09/rrr-review.jpg',
              logoUrl:
                  'https://www.careerguide.com/career/wp-content/uploads/2023/10/RRR_full_form-1024x576.jpg',
              day: '27',
              month: 'june',
              overView:
                  'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
            ),
          ],
        ),
      ),
    );
  }
}
