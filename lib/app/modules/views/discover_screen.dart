import 'package:flutter/material.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  String _selectedCategory = 'Football'; // Menyimpan kategori yang dipilih

  // Berita untuk masing-masing kategori
  final Map<String, List<Map<String, String>>> categoryNews = {
    'Football': [
      {
        'source': 'Skysport',
        'time': '7m Ago',
        'imageUrl':
            'https://cdn.rri.co.id/berita/Pusat_Pemberitaan/o/1723796426220-Snapinsta.app_454715486_1004106861455692_1509171334412741554_n_1080/89978gdeol8bzlb.jpeg',
        'title': 'How bad is Man Utd\'s away form?',
        'description':
            'Man Utd manager Erik ten Hag claims the club is not in crisis - but many disagree...',
      },
      {
        'source': 'The Guardian',
        'time': '10m Ago',
        'imageUrl':
            'https://images2.minutemediacdn.com/image/upload/c_fill,w_720,ar_16:9,f_auto,q_auto,g_auto/shape/cover/sport/df3d06cef57a697c27cedd722c37281b414bb74015bc497eb7c387666281a90d.jpg',
        'title': 'Chelsea secures win over Bournemouth',
        'description':
            'Chelsea managed to secure a close victory against Bournemouth in their latest match...',
      },
    ],
    'NFL': [
      {
        'source': 'NFL Network',
        'time': '5m Ago',
        'imageUrl':
            'https://wwwimage-us.pplusstatic.com/base/files/blog/61/65/85/3e76de8f-2078-4b7e-a8d8-905849fafbad.jpg',
        'title': 'NFL Week 12 Recap: Giants vs Cowboys',
        'description':
            'The Cowboys dominated the Giants in Week 12, clinching a crucial victory...',
      },
      {
        'source': 'ESPN',
        'time': '15m Ago',
        'imageUrl':
            'https://media.cnn.com/api/v1/images/stellar/prod/230905135836-01-daewood-davis-injury-0826.jpg?q=w_2000,c_fill',
        'title': 'Packers quarterback shines against Lions',
        'description':
            'A stellar performance by the Packers QB, leading them to a stunning win over the Lions...',
      },
    ],
    'NBA': [
      {
        'source': 'NBA.com',
        'time': '2m Ago',
        'imageUrl':
            'https://www.sportico.com/wp-content/uploads/2024/04/GettyImages-2131507355-e1713470095438.jpg?w=1280&h=718&crop=1',
        'title': 'Lakers defeat Warriors in OT thriller',
        'description':
            'The Lakers won an overtime thriller against the Warriors in a match filled with drama...',
      },
      {
        'source': 'Bleacher Report',
        'time': '12m Ago',
        'imageUrl':
            'https://image.api.playstation.com/vulcan/ap/rnd/202406/2508/449f45011df69c23f3faad46f889ceae13316dc0c2d54d6f.jpg',
        'title': 'Bucks edge out Celtics in tight contest',
        'description':
            'In a nail-biting match, the Bucks secured a win over the Celtics to remain top of the East...',
      },
    ],
    'Cricket': [
      {
        'source': 'BBC Sport',
        'time': '20m Ago',
        'imageUrl':
            'https://cdn.britannica.com/63/211663-050-A674D74C/Jonny-Bairstow-batting-semifinal-match-England-Australia-2019.jpg',
        'title': 'India defeats Australia in World Cup final',
        'description':
            'India won the World Cup after a hard-fought battle with Australia...',
      },
      {
        'source': 'CricBuzz',
        'time': '30m Ago',
        'imageUrl':
            'https://images.pexels.com/photos/3628912/pexels-photo-3628912.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        'title': 'England sets new record in Test match',
        'description':
            'England sets a new record in the longest format of the game, defeating South Africa...',
      },
    ],
    'MLB': [
      {
        'source': 'MLB.com',
        'time': '1h Ago',
        'imageUrl':
            'https://img.mlbstatic.com/mlb-images/image/upload/t_16x9/t_w2208/mlb/ngciyglhkmyvmgogos8j.jpg',
        'title': 'Yankees secure wild card spot in playoffs',
        'description':
            'The Yankees sealed their wild card spot with a dramatic victory over the Red Sox...',
      },
      {
        'source': 'FOX Sports',
        'time': '25m Ago',
        'imageUrl':
            'https://a.espncdn.com/photo/2023/0926/mlb_power26_cr_16x9.jpg',
        'title': 'Dodgers clinch NL division title',
        'description':
            'The Dodgers clinched the NL division title with a dominant win against the Padres...',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xFF0A1C2C), // Warna latar belakang yang lebih gelap dan netral
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kategori Tab
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryButton('Football', context),
                    _buildCategoryButton('NFL', context),
                    _buildCategoryButton('NBA', context),
                    _buildCategoryButton('Cricket', context),
                    _buildCategoryButton('MLB', context),
                  ],
                ),
              ),
            ),
            Divider(),

            // Menampilkan berita berdasarkan kategori yang dipilih
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: categoryNews[_selectedCategory]?.length ?? 0,
                itemBuilder: (context, index) {
                  var news = categoryNews[_selectedCategory]![index];
                  return _buildNewsItem(
                    news['source']!,
                    news['time']!,
                    news['imageUrl']!,
                    news['title']!,
                    news['description']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membuat tombol kategori
  Widget _buildCategoryButton(String title, BuildContext context) {
    bool isSelected =
        title == _selectedCategory; // Memeriksa apakah kategori terpilih
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedCategory = title; // Mengubah kategori terpilih
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? Color(0xFF005B96)
              : Color(0xFF003366), // Biru tua untuk tidak terpilih
          foregroundColor: isSelected ? Colors.white : Colors.white70,
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected
                ? FontWeight.bold
                : FontWeight.normal, // Menebalkan teks jika terpilih
          ),
        ),
      ),
    );
  }

  // Widget untuk item berita
  Widget _buildNewsItem(
    String source,
    String time,
    String imageUrl,
    String title,
    String description,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.network(
              imageUrl,
              width: 20,
              height: 20,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.error, color: Colors.red),
            ),
            SizedBox(width: 8),
            Text(
              source,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
            Spacer(),
            Text(
              time,
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(color: Colors.white),
        ),
        Divider(),
      ],
    );
  }
}
