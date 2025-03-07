import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'test_screen.dart';
import 'learn_screen.dart';
import 'profile_screen.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'dart:async';
import 'dart:math';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  // Sensor-related variables
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  StreamSubscription<int>? _proximitySubscription;
  DateTime? _lastShakeTime;
  bool _isNear = false;

  // Shake detection variables
  static const double _shakeThreshold = 15.0;
  static const Duration _shakeDebounce = Duration(seconds: 1);

  final List<Widget> _screens = [
    const HomeScreen(),
    const TestScreen(),
    const LearnScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _initSensors();
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    _proximitySubscription?.cancel();
    super.dispose();
  }

  void _initSensors() {
    // Initialize accelerometer for shake detection
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      _detectShake(event);
    });

    // Initialize proximity sensor using proximity_sensor package
    _proximitySubscription = ProximitySensor.events.listen((int isNear) {
      // 0 means proximity is near (object detected)
      bool proximityNear = isNear == 0;

      if (proximityNear && !_isNear) {
        setState(() => _isNear = true);
        _showSupportPopup();
      } else if (!proximityNear && _isNear) {
        setState(() => _isNear = false);
      }
    });
  }

  void _detectShake(AccelerometerEvent event) {
    double acceleration =
        sqrt(event.x * event.x + event.y * event.y + event.z * event.z) -
            9.8; // Subtracting gravity force

    if (acceleration > _shakeThreshold) {
      final now = DateTime.now();
      if (_lastShakeTime == null ||
          now.difference(_lastShakeTime!) > _shakeDebounce) {
        _lastShakeTime = now;
        _showReportIssuePopup();
      }
    }
  }

  void _showReportIssuePopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report an Issue'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                'We detected you shook your device. Would you like to report an issue?'),
            const SizedBox(height: 16),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Describe the issue you encountered...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement issue reporting logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Issue reported. Thank you!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink.shade400,
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _showSupportPopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Need Support?'),
        content: const Text(
            'We detected your device is close to your face. Do you need help with the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No Thanks', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement support contact logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Connecting to support...')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink.shade400,
            ),
            child: const Text('Get Help'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.pink.shade100.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.quiz_rounded),
                label: 'Test',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_rounded),
                label: 'Learn',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.pink.shade400,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            onTap: _onItemTapped,
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
