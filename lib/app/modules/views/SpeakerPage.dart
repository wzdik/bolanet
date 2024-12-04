import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SpeakerPage extends StatefulWidget {
  const SpeakerPage({super.key});

  @override
  _SpeakerPageState createState() => _SpeakerPageState();
}

class _SpeakerPageState extends State<SpeakerPage> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  bool _isPaused = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    // Menangani perubahan posisi audio
    _audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        _currentPosition = position;
      });
    });

    // Menangani perubahan durasi audio
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        _totalDuration = duration;
      });
    });

    // Menangani perubahan status pemutaran (play, pause, complete)
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed) {
        setState(() {
          _isPlaying = false;
          _isPaused = false;
          _currentPosition = Duration.zero;
        });
      }
    });
  }

  // Fungsi untuk memutar audio dari URL
  Future<void> playAudio() async {
    String audioUrl =
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'; // Ganti dengan URL audio yang sesuai
    await _audioPlayer.play(UrlSource(audioUrl));
    setState(() {
      _isPlaying = true;
      _isPaused = false;
    });
  }

  // Fungsi untuk menjeda audio
  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
      _isPaused = true;
    });
  }

  // Fungsi untuk melanjutkan audio setelah dijeda
  Future<void> resumeAudio() async {
    await _audioPlayer.resume();
    setState(() {
      _isPlaying = true;
      _isPaused = false;
    });
  }

  // Fungsi untuk menghentikan audio dan reset posisi
  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
      _isPaused = false;
      _currentPosition = Duration.zero;
    });
  }

  // Fungsi untuk mengatur posisi audio (seek)
  Future<void> seekAudio(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Speaker Page')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Current Position: $_currentPosition'),
          Text('Total Duration: $_totalDuration'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: _isPlaying || _isPaused ? null : playAudio,
              ),
              IconButton(
                icon: Icon(Icons.pause),
                onPressed: !_isPlaying || _isPaused ? null : pauseAudio,
              ),
              IconButton(
                icon: Icon(Icons.stop),
                onPressed: !_isPlaying && !_isPaused ? null : stopAudio,
              ),
            ],
          ),
          Slider(
            value: _currentPosition.inSeconds.toDouble(),
            max: _totalDuration.inSeconds.toDouble(),
            onChanged: (value) {
              seekAudio(Duration(seconds: value.toInt()));
            },
          ),
        ],
      ),
    );
  }
}
