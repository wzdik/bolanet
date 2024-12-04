import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  String selectedCategory = 'Football';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1C2C), // Warna latar belakang gelap
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tab Kategori
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryButton('Football'),
                  _buildCategoryButton('NFL'),
                  _buildCategoryButton('NBA'),
                  _buildCategoryButton('Cricket'),
                  _buildCategoryButton('MLB'),
                ],
              ),
            ),
          ),

          // Konten Berdasarkan Kategori
          Expanded(
            child: _buildContentByCategory(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String title) {
    final isSelected = selectedCategory == title;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedCategory = title;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? Color(0xFF005B96) // Biru terang untuk kategori terpilih
              : Color(0xFF003366), // Biru tua untuk kategori tidak terpilih
          foregroundColor: isSelected ? Colors.white : Colors.white70,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ),
        child: Text(title),
      ),
    );
  }

  Widget _buildContentByCategory() {
    switch (selectedCategory) {
      case 'NFL':
        return _buildMatchList([
          {'team1': 'Patriots', 'team2': 'Broncos', 'time': '10:00 AM'},
          {'team1': 'Cowboys', 'team2': '49ers', 'time': '1:00 PM'},
          {'team1': 'Eagles', 'team2': 'Packers', 'time': '3:00 PM'},
          {'team1': 'Chiefs', 'team2': 'Bears', 'time': '6:00 PM'},
          {'team1': 'Jets', 'team2': 'Dolphins', 'time': '8:00 PM'},
          {'team1': 'Ravens', 'team2': 'Bengals', 'time': '9:30 PM'},
        ]);
      case 'NBA':
        return _buildMatchList([
          {'team1': 'Lakers', 'team2': 'Celtics', 'time': '7:00 PM'},
          {'team1': 'Warriors', 'team2': 'Heat', 'time': '9:00 PM'},
          {'team1': 'Nets', 'team2': 'Bulls', 'time': '6:00 PM'},
          {'team1': 'Suns', 'team2': 'Clippers', 'time': '8:00 PM'},
          {'team1': 'Jazz', 'team2': 'Nuggets', 'time': '10:00 PM'},
          {'team1': 'Raptors', 'team2': 'Hawks', 'time': '11:00 PM'},
        ]);
      case 'Cricket':
        return _buildMatchList([
          {'team1': 'India', 'team2': 'Australia', 'time': '2:00 PM'},
          {'team1': 'England', 'team2': 'Pakistan', 'time': '6:00 PM'},
          {'team1': 'New Zealand', 'team2': 'South Africa', 'time': '12:00 PM'},
          {'team1': 'Sri Lanka', 'team2': 'Bangladesh', 'time': '4:00 PM'},
          {'team1': 'Afghanistan', 'team2': 'Zimbabwe', 'time': '7:00 PM'},
          {'team1': 'Ireland', 'team2': 'Scotland', 'time': '9:00 PM'},
        ]);
      case 'MLB':
        return _buildMatchList([
          {'team1': 'Yankees', 'team2': 'Red Sox', 'time': '4:00 PM'},
          {'team1': 'Dodgers', 'team2': 'Giants', 'time': '7:00 PM'},
          {'team1': 'Cubs', 'team2': 'Mets', 'time': '2:00 PM'},
          {'team1': 'Astros', 'team2': 'Angels', 'time': '5:00 PM'},
          {'team1': 'Rays', 'team2': 'Blue Jays', 'time': '8:00 PM'},
          {'team1': 'Mariners', 'team2': 'Orioles', 'time': '9:30 PM'},
        ]);
      default: // Football
        return _buildMatchList([
          {'team1': 'Manchester United', 'team2': 'Chelsea', 'time': '5:00 PM'},
          {'team1': 'Barcelona', 'team2': 'Real Madrid', 'time': '8:00 PM'},
          {'team1': 'Liverpool', 'team2': 'Arsenal', 'time': '3:00 PM'},
          {'team1': 'Bayern', 'team2': 'Dortmund', 'time': '6:00 PM'},
          {'team1': 'PSG', 'team2': 'Marseille', 'time': '9:00 PM'},
          {'team1': 'Inter', 'team2': 'Milan', 'time': '10:30 PM'},
        ]);
    }
  }

  Widget _buildMatchList(List<Map<String, String>> matches) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          color: Color(0xFF003366), // Biru tua untuk kartu pertandingan
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${match['team1']} vs ${match['team2']}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Time: ${match['time']}',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
