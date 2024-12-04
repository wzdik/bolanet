import 'dart:io';
import 'package:bolanet76/app/modules/views/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'SettingsPage.dart';
import 'SpeakerPage.dart';
import 'LocationPage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  VideoPlayerController? _videoController;

  final _storage = GetStorage();

  String? _storedImagePath;
  String? _storedVideoPath;

  @override
  void initState() {
    super.initState();
    _storedImagePath = _storage.read('profile_image');
    _storedVideoPath = _storage.read('profile_video');
    if (_storedVideoPath != null) {
      _initializeVideoController(_storedVideoPath!);
    }
  }

  Future<void> _pickMedia(bool isVideo, ImageSource source) async {
    final XFile? selectedFile = await (isVideo
        ? _picker.pickVideo(source: source)
        : _picker.pickImage(source: source));

    if (selectedFile != null) {
      setState(() {
        if (isVideo) {
          _storedVideoPath = selectedFile.path;
          _storage.write('profile_video', _storedVideoPath);
          _initializeVideoController(_storedVideoPath!);
        } else {
          _storedImagePath = selectedFile.path;
          _storage.write('profile_image', _storedImagePath);
        }
      });
    }
  }

  void _initializeVideoController(String path) {
    _videoController = VideoPlayerController.file(File(path))
      ..initialize().then((_) {
        setState(() {});
        _videoController?.setLooping(true);
        _videoController?.play();
      }).catchError((error) {
        print('Error initializing video: $error');
      });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 24.0),
          _buildStatsSection(),
          const SizedBox(height: 24.0),
          _buildOptionsSection(context),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _buildProfileHeader() {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc('x3xm5nObS5aNHzF17O9H')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.green));
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('User data not found.', style: TextStyle(color: Colors.white)));
        }

        var userData = snapshot.data!.data() as Map<String, dynamic>;
        String name = userData['name'] ?? 'No name provided';
        String bio = userData['bio'] ?? 'No bio available';

        return Column(
          children: [
            GestureDetector(
              onTap: () => _showMediaOptions(),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.green,
                child: ClipOval(
                  child: _storedVideoPath != null
                      ? AspectRatio(
                          aspectRatio: 1,
                          child: VideoPlayer(_videoController!),
                        )
                      : _storedImagePath != null
                          ? Image.file(
                              File(_storedImagePath!),
                              fit: BoxFit.cover,
                              width: 120,
                              height: 120,
                            )
                          : const Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: Colors.black,
                            ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              bio,
              style: TextStyle(color: Colors.grey[400], fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }

  void _showMediaOptions() {
    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMediaOption(Icons.photo_library, 'Select Photo from Gallery', () {
              Navigator.pop(context);
              _pickMedia(false, ImageSource.gallery);
            }),
            _buildMediaOption(Icons.videocam, 'Select Video from Gallery', () {
              Navigator.pop(context);
              _pickMedia(true, ImageSource.gallery);
            }),
            _buildMediaOption(Icons.camera_alt, 'Take Photo with Camera', () {
              Navigator.pop(context);
              _pickMedia(false, ImageSource.camera);
            }),
            _buildMediaOption(Icons.videocam, 'Record Video with Camera', () {
              Navigator.pop(context);
              _pickMedia(true, ImageSource.camera);
            }),
          ],
        );
      },
    );
  }

  Widget _buildMediaOption(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  Widget _buildStatsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem('Posts', '25'),
        _buildStatItem('Followers', '1.2K'),
        _buildStatItem('Following', '180'),
      ],
    );
  }

  Widget _buildStatItem(String label, String count) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(color: Colors.grey[400]),
        ),
      ],
    );
  }

  Widget _buildOptionsSection(BuildContext context) {
    return Column(
      children: [
        _buildOptionItem(Icons.speaker, 'Speaker', () {
          Get.to(() => SpeakerPage());
        }),
        _buildOptionItem(Icons.settings, 'Settings', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsPage()),
          );
        }),
        _buildOptionItem(Icons.map, 'Location', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LocationPage()),
          );
        }),
        _buildOptionItem(Icons.logout, 'Log Out', () {
          _logout();
        }),
      ],
    );
  }

  Widget _buildOptionItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _logout() {
    _storage.remove('profile_image');
    _storage.remove('profile_video');
    Get.offAll(() => LoginPage());
  }
}
