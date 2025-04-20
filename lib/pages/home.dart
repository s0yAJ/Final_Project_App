import 'package:final_proyect/pages/MiembrosPage.dart';
import 'package:final_proyect/pages/albergues_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';

import 'Measures.dart';
import 'Abous.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();
  final List<String> imageList = [
    'assets/acciones1.jpg',
    'assets/acciones2.jpeg',
    'assets/acciones3.jpg',
  ];

  final List<Map<String, dynamic>> gridItems = [
    {
      'icon': Icons.warning,
      'title': 'Medidas Preventivas',
      'color': Colors.red
    },
    {'icon': Icons.person_4_sharp, 'title': 'Miembros', 'color': Colors.blue},
    {'icon': Icons.info, 'title': 'Acerca de', 'color': Colors.green},
    {'icon': Icons.house, 'title': 'Albergues', 'color': Colors.orange},
  ];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.page == imageList.length - 1) {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Padding(
      padding: EdgeInsets.all(30),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SizedBox(height: topPadding > 30 ? 10 : 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(7),
                child: Image.asset(
                  'assets/banner.png',
                  width: MediaQuery.of(context).size.width,
                  height: 125,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        imageList[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[200],
                          child: const Center(child: Icon(Icons.broken_image)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            SmoothPageIndicator(
              controller: _pageController,
              count: imageList.length,
              effect: const WormEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: Colors.grey,
                dotColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.1,
                  children: gridItems.map((item) {
                    return _buildGridItem(
                      item['icon'] as IconData,
                      item['title'] as String,
                      item['color'] as Color,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(IconData icon, String title, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (title == 'Medidas Preventivas') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Measures(),
              ),
            );
          } else if (title == 'Acerca de') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AcercaPage(),
              ),
            );
          } else if (title == 'Miembros') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MiembrosPage(),
              ),
            );
          } else if (title == 'Albergues') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AlberguesScreen(),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$title aún no está disponible.')),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color.withOpacity(0.1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
