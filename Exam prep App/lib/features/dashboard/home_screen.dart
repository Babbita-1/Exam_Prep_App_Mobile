import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Prep App'),
        backgroundColor: Colors.pink.shade100,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const SizedBox(height: 10),
              _buildWelcomeCard(),
              const SizedBox(height: 20),
              _buildStatsSection(),
              const SizedBox(height: 20),
              _buildRecentActivity(),
              const SizedBox(height: 20),
              _buildQuickActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.pink.shade200,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.pink.shade50,
                  child: Icon(Icons.person, color: Colors.pink.shade400),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Continue your learning journey',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 15),
            LinearProgressIndicator(
              value: 0.7,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            const SizedBox(height: 5),
            const Text(
              '70% of weekly goal completed',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Stats',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                  'Tests Taken', '12', Icons.check_circle_outline),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildStatCard('Average Score', '85%', Icons.bar_chart),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildStatCard('Topics Covered', '18', Icons.menu_book),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildStatCard('Study Hours', '24h', Icons.access_time),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(icon, color: Colors.pink.shade300, size: 30),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade400,
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildActivityItem('Mathematics Quiz', 'Score: 85%', Icons.calculate),
        _buildActivityItem(
            'Physics Notes', 'Last accessed: Yesterday', Icons.science),
        _buildActivityItem(
            'Chemistry Test', 'Score: 92%', Icons.science_outlined),
      ],
    );
  }

  Widget _buildActivityItem(String title, String subtitle, IconData icon) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.pink.shade50,
          child: Icon(icon, color: Colors.pink.shade300),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildActionButton('Practice Test', Icons.quiz),
            _buildActionButton('Study Notes', Icons.book),
            _buildActionButton('Flashcards', Icons.flip),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.pink.shade100,
          child: Icon(icon, color: Colors.pink.shade700, size: 25),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
