import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:math';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage>
    with SingleTickerProviderStateMixin {
  String _latitude = "";
  String _longitude = "";
  String _locationMessage = "Menunggu lokasi...";
  String _address = "Menunggu alamat...";
  double? _distanceToDestination;
  String _destinationMessage = "Masukkan nama kota tujuan.";
  TextEditingController _cityController = TextEditingController();
  double? _destinationLatitude;
  double? _destinationLongitude;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = "Layanan lokasi dinonaktifkan.";
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = "Izin lokasi ditolak.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = "Izin lokasi ditolak secara permanen.";
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _latitude = position.latitude.toString();
      _longitude = position.longitude.toString();
      _locationMessage = "Latitude: $_latitude, Longitude: $_longitude";
    });

    await _getAddressFromCoordinates(position.latitude, position.longitude);
  }

  Future<void> _getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      setState(() {
        _address = "${place.street}, ${place.subLocality}, "
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      setState(() {
        _address = "Gagal mendapatkan alamat: $e";
      });
    }
  }

  Future<void> _setDestinationCoordinates() async {
    if (_cityController.text.isNotEmpty) {
      try {
        List<Location> locations =
            await locationFromAddress(_cityController.text);
        Location destination = locations[0];
        setState(() {
          _destinationLatitude = destination.latitude;
          _destinationLongitude = destination.longitude;
          _destinationMessage =
              "Koordinat tujuan: Lat ${_destinationLatitude}, Lon ${_destinationLongitude}";
        });
      } catch (e) {
        setState(() {
          _destinationMessage =
              "Gagal mendapatkan koordinat untuk kota ini: $e";
        });
      }
    }
  }

  void _calculateDistance() {
    if (_latitude.isNotEmpty &&
        _longitude.isNotEmpty &&
        _destinationLatitude != null &&
        _destinationLongitude != null) {
      double userLat = double.parse(_latitude);
      double userLon = double.parse(_longitude);
      double destLat = _destinationLatitude!;
      double destLon = _destinationLongitude!;

      const R = 6371; // Radius bumi dalam kilometer
      double dLat = _toRadians(destLat - userLat);
      double dLon = _toRadians(destLon - userLon);
      double a = sin(dLat / 2) * sin(dLat / 2) +
          cos(_toRadians(userLat)) *
              cos(_toRadians(destLat)) *
              sin(dLon / 2) *
              sin(dLon / 2);
      double c = 2 * atan2(sqrt(a), sqrt(1 - a));
      double distance = R * c;

      setState(() {
        _distanceToDestination = distance;
        _destinationMessage = "Jarak ke tujuan: ${distance.toStringAsFixed(2)} km";
      });
    }
  }

  void _navigateToDestination() {
    if (_destinationLatitude != null && _destinationLongitude != null) {
      final url =
          'https://www.google.com/maps/dir/$_latitude,$_longitude/$_destinationLatitude,$_destinationLongitude';
      _launchURL(url);
    }
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  Widget _buildBackgroundAnimation() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.blueAccent,
                Colors.lightBlueAccent,
              ],
              stops: [
                0.0,
                0.5 + 0.5 * _animationController.value,
                1.0,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF004A7C),
        title: const Text("Lokasi Saya"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          _buildBackgroundAnimation(),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Text(
                  _locationMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _getCurrentLocation,
                  child: const Text("Cari Lokasi Saya"),
                ),
                const SizedBox(height: 20),
                Text(
                  'Alamat: $_address',
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: "Nama Kota Tujuan",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _setDestinationCoordinates,
                  child: const Text("Setel Tujuan"),
                ),
                ElevatedButton(
                  onPressed: _calculateDistance,
                  child: const Text("Hitung Jarak"),
                ),
                ElevatedButton(
                  onPressed: _navigateToDestination,
                  child: const Text("Navigasi ke Tujuan"),
                ),
                const SizedBox(height: 20),
                Text(
                  _destinationMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
