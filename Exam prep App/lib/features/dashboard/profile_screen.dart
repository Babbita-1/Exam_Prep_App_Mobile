import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.pink.shade100,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.pink.shade50, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                _buildProfileHeader(),
                const SizedBox(height: 20),
                _buildStatsSection(),
                const SizedBox(height: 20),
                _buildProgressSection(),
                const SizedBox(height: 20),
                _buildOptionsSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
                'https://randomuser.me/api/portraits/women/44.jpg'),
          ),
          const SizedBox(height: 16),
          const Text(
            'Sarah Johnson',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Computer Science Student',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink.shade400,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem('Tests Taken', '24'),
        _buildStatDivider(),
        _buildStatItem('Avg. Score', '85%'),
        _buildStatDivider(),
        _buildStatItem('Study Hours', '42'),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.pink.shade400,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey.shade300,
    );
  }

  Widget _buildProgressSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Progress',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildProgressItem('Mathematics', 0.75),
            const SizedBox(height: 12),
            _buildProgressItem('Physics', 0.60),
            const SizedBox(height: 12),
            _buildProgressItem('Chemistry', 0.45),
            const SizedBox(height: 12),
            _buildProgressItem('Biology', 0.80),
            const SizedBox(height: 12),
            _buildProgressItem('Computer Science', 0.90),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressItem(String subject, double progress) {
    final percentage = (progress * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subject,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              '$percentage%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(
            _getColorForProgress(progress),
          ),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Color _getColorForProgress(double progress) {
    if (progress >= 0.8) return Colors.green;
    if (progress >= 0.6) return Colors.blue;
    if (progress >= 0.4) return Colors.amber;
    return Colors.red;
  }

  Widget _buildOptionsSection(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOptionItem(
              context,
              Icons.history,
              'Test History',
              'View your past test results',
              Colors.blue.shade100,
            ),
            _buildOptionItem(
              context,
              Icons.bookmark,
              'Bookmarks',
              'Access your saved notes and questions',
              Colors.amber.shade100,
            ),
            _buildOptionItem(
              context,
              Icons.trending_up,
              'Performance Analytics',
              'Detailed stats on your learning progress',
              Colors.green.shade100,
            ),
            _buildOptionItem(
              context,
              Icons.notifications,
              'Notification Settings',
              'Customize your notification preferences',
              Colors.purple.shade100,
            ),
            _buildOptionItem(
              context,
              Icons.help_outline,
              'Help & Support',
              'Get assistance and contact support',
              Colors.orange.shade100,
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Color iconBgColor, {
    bool isLast = false,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconBgColor.withOpacity(1.0)),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        if (!isLast)
          Divider(
            height: 1,
            thickness: 1,
            indent: 70,
            color: Colors.grey.shade200,
          ),
      ],
    );
  }
}
