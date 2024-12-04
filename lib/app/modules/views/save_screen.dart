import 'package:flutter/material.dart';

class SaveScreen extends StatelessWidget {
  const SaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSavedItem(
            'Skysport',
            '7m Ago',
            'https://images.ps-aws.com/c?url=https%3A%2F%2Fd2x51gyc4ptf2q.cloudfront.net%2Fcontent%2Fuploads%2F2024%2F10%2F31205933%2FErik-ten-Hag-Ruben-Amorim-F365-1320x742.jpg',
            'How bad is Man Utd\'s away form?',
            'Man Utd manager Erik ten Hag claims the club is not in crisis...',
          ),
          _buildSavedItem(
            'The Guardian',
            '1h Ago',
            'https://dnaberita.com/wp-content/uploads/2024/03/Chelsea.jpg', // Ganti dengan path gambar yang sesuai
            'Chelsea continues their strong form',
            'Chelsea has been performing well under the new manager...',
          ),
          _buildSavedItem(
            'ESPN',
            '2h Ago',
            'https://a.espncdn.com/photo/2024/0417/r1320111_1296x729_16-9.jpg', // Ganti dengan path gambar yang sesuai
            'How bad is Barcelona financial situation',
            'the interest they have to pay on the loans and credit they have taken out...',
          ),
        ],
      ),
    );
  }

  // Widget untuk setiap item yang disimpan
  Widget _buildSavedItem(
    String source,
    String time,
    String imagePath,
    String title,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
              child: Image.network(
                imagePath,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sumber dan Waktu
                  Row(
                    children: [
                      Text(
                        source,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: const Color(
                              0xFF003366), // Dark blue for source text
                        ),
                      ),
                      Spacer(),
                      Text(
                        time,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),

                  // Judul
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: const Color(0xFF003366), // Dark blue for title
                    ),
                  ),
                  SizedBox(height: 8.0),

                  // Deskripsi
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
