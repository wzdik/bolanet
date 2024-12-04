import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  // Fungsi untuk membaca data pengguna dari Firestore
  Future<void> _loadSettings() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc('x3xm5nObS5aNHzF17O9H') // ID pengguna
        .get();

    if (userDoc.exists) {
      var data = userDoc.data() as Map<String, dynamic>;
      nameController.text = data['name'] ?? '';
      addressController.text = data['address'] ?? '';
      bioController.text = data['bio'] ?? '';
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSettings(); // Memuat data saat halaman dibuka
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: bioController,
              decoration: InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _saveSettings,
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: _deleteSettings,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menyimpan data (Create / Update)
  Future<void> _saveSettings() async {
    String name = nameController.text;
    String address = addressController.text;
    String bio = bioController.text;

    // Simpan atau update ke Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc('x3xm5nObS5aNHzF17O9H')
        .set(
      {
        'name': name,
        'address': address,
        'bio': bio,
      },
      SetOptions(merge: true), // Mengupdate data jika sudah ada
    );

    print("Data tersimpan: $name, $address, $bio");
  }

  // Fungsi untuk menghapus data (Delete)
  Future<void> _deleteSettings() async {
    // Hapus data dari Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc('x3xm5nObS5aNHzF17O9H')
        .delete();

    // Bersihkan semua text controller
    nameController.clear();
    addressController.clear();
    bioController.clear();

    print("Data dihapus");
  }
}
