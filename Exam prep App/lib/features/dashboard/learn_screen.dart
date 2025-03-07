import 'package:flutter/material.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> subjects = [
      {
        'name': 'Mathematics',
        'icon': Icons.calculate,
        'color': Colors.pink.shade100,
        'topics': 8,
        'progress': 0.7
      },
      {
        'name': 'Physics',
        'icon': Icons.science,
        'color': Colors.pink.shade200,
        'topics': 10,
        'progress': 0.5
      },
      {
        'name': 'Chemistry',
        'icon': Icons.science_outlined,
        'color': Colors.pink.shade300,
        'topics': 12,
        'progress': 0.3
      },
      {
        'name': 'Biology',
        'icon': Icons.biotech,
        'color': Colors.pink.shade100,
        'topics': 9,
        'progress': 0.6
      },
      {
        'name': 'Computer Science',
        'icon': Icons.computer,
        'color': Colors.pink.shade200,
        'topics': 7,
        'progress': 0.4
      },
      {
        'name': 'English',
        'icon': Icons.book,
        'color': Colors.pink.shade300,
        'topics': 6,
        'progress': 0.8
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn'),
        backgroundColor: Colors.pink.shade100,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.bookmark),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContinueLearningSection(),
              const SizedBox(height: 20),
              const Text(
                'Subjects',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    final subject = subjects[index];
                    return _buildSubjectCard(
                      context,
                      subject['name'],
                      subject['icon'],
                      subject['color'],
                      subject['topics'],
                      subject['progress'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContinueLearningSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade300, Colors.pink.shade200],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.shade100.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Continue Learning',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: Icon(Icons.science, color: Colors.pink.shade400),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Physics: Mechanics',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Newton\'s Laws of Motion',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: 0.4,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '40% Complete',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectCard(
    BuildContext context,
    String subject,
    IconData icon,
    Color color,
    int topics,
    double progress,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubjectDetailScreen(subject: subject),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color,
                radius: 25,
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$topics topics',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${(progress * 100).toInt()}% Complete',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey.shade600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubjectDetailScreen extends StatelessWidget {
  final String subject;

  const SubjectDetailScreen({Key? key, required this.subject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> topics = _getTopics(subject);

    return Scaffold(
      appBar: AppBar(
        title: Text(subject),
        backgroundColor: Colors.pink.shade100,
        elevation: 0,
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
          child: ListView.builder(
            itemCount: topics.length,
            itemBuilder: (context, index) {
              final topic = topics[index];
              return _buildTopicCard(
                context,
                topic['title'],
                topic['description'],
              );
            },
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getTopics(String subject) {
    // Return topics based on subject
    switch (subject) {
      case 'Mathematics':
        return [
          {
            'title': 'Algebra',
            'description': 'Equations, inequalities, functions, and graphs.'
          },
          {
            'title': 'Geometry',
            'description': 'Shapes, sizes, positions, and dimensions.'
          },
          {
            'title': 'Calculus',
            'description': 'Limits, derivatives, and integrals.'
          },
          {
            'title': 'Probability and Statistics',
            'description': 'Data analysis and random phenomena.'
          },
        ];
      case 'Physics':
        return [
          {
            'title': 'Mechanics',
            'description': 'Motion, forces, energy, and momentum.'
          },
          {
            'title': 'Thermodynamics',
            'description': 'Heat, energy, and the laws governing them.'
          },
          {
            'title': 'Electromagnetism',
            'description': 'Electricity, magnetism, and electromagnetic waves.'
          },
          {
            'title': 'Optics',
            'description': 'Properties and behavior of light.'
          },
        ];
      case 'Chemistry':
        return [
          {
            'title': 'Atomic Structure',
            'description': 'Atoms, elements, and the periodic table.'
          },
          {
            'title': 'Chemical Bonding',
            'description': 'Ionic, covalent, and metallic bonds.'
          },
          {
            'title': 'Acids and Bases',
            'description': 'pH scale, neutralization, and buffers.'
          },
          {
            'title': 'Organic Chemistry',
            'description': 'Carbon-based compounds and their reactions.'
          },
        ];
      default:
        return [
          {'title': 'Topic 1', 'description': 'Description for Topic 1'},
          {'title': 'Topic 2', 'description': 'Description for Topic 2'},
          {'title': 'Topic 3', 'description': 'Description for Topic 3'},
        ];
    }
  }

  Widget _buildTopicCard(
      BuildContext context, String title, String description) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TopicDetailScreen(subject: subject, topic: title),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopicDetailScreen extends StatelessWidget {
  final String subject;
  final String topic;

  const TopicDetailScreen(
      {Key? key, required this.subject, required this.topic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topic),
        backgroundColor: Colors.pink.shade100,
        elevation: 0,
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Introduction
                        const Text(
                          'Introduction',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _getTopicContent(subject, topic, 'introduction'),
                        const Divider(height: 30),

                        // Key Points
                        const Text(
                          'Key Points',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _getTopicContent(subject, topic, 'keyPoints'),
                        const Divider(height: 30),

                        // Examples
                        const Text(
                          'Examples',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _getTopicContent(subject, topic, 'examples'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.book),
                  label: const Text('Mark as Completed'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade400,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTopicContent(String subject, String topic, String section) {
    // Mock content for specific topics
    if (subject == 'Physics' && topic == 'Mechanics') {
      if (section == 'introduction') {
        return const Text(
          'Mechanics is the branch of physics that deals with the motion of objects under the influence of forces. '
          'It forms the foundation of classical physics and is essential for understanding the physical world around us.',
          style: TextStyle(fontSize: 16),
        );
      } else if (section == 'keyPoints') {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
                '• Newton\'s First Law: An object at rest stays at rest, and an object in motion stays in motion with the same speed and direction, unless acted upon by an external force.'),
            SizedBox(height: 8),
            Text(
                '• Newton\'s Second Law: Force equals mass times acceleration (F = ma).'),
            SizedBox(height: 8),
            Text(
                '• Newton\'s Third Law: For every action, there is an equal and opposite reaction.'),
            SizedBox(height: 8),
            Text(
                '• Conservation of Momentum: In a closed system, the total momentum remains constant.'),
            SizedBox(height: 8),
            Text(
                '• Conservation of Energy: Energy cannot be created or destroyed, only transformed from one form to another.'),
          ],
        );
      } else {
        // examples
        return const Text(
          'Example 1: A 2 kg object is subjected to a force of 10 N. The acceleration of the object is a = F/m = 10/2 = 5 m/s².\n\n'
          'Example 2: A rocket propels itself forward by expelling gas backwards. The forward motion of the rocket is a reaction to the backward motion of the expelled gas (Newton\'s Third Law).',
          style: TextStyle(fontSize: 16),
        );
      }
    } else if (subject == 'Mathematics' && topic == 'Algebra') {
      if (section == 'introduction') {
        return const Text(
          'Algebra is a branch of mathematics dealing with symbols and the rules for manipulating these symbols. '
          'It is a unifying thread of almost all of mathematics and includes everything from solving elementary equations to studying abstractions.',
          style: TextStyle(fontSize: 16),
        );
      } else if (section == 'keyPoints') {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('• Variables: Letters that represent unknown values'),
            SizedBox(height: 8),
            Text(
                '• Expressions: Combinations of variables, numbers, and operations'),
            SizedBox(height: 8),
            Text(
                '• Equations: Mathematical statements asserting that two expressions are equal'),
            SizedBox(height: 8),
            Text(
                '• Functions: Relations that assign exactly one output to each input'),
            SizedBox(height: 8),
            Text(
                '• Polynomials: Expressions consisting of variables and coefficients with operations of addition, subtraction, and multiplication'),
          ],
        );
      } else {
        // examples
        return const Text(
          'Example 1: Solve for x in the equation 3x + 5 = 14\n'
          '3x + 5 = 14\n'
          '3x = 14 - 5\n'
          '3x = 9\n'
          'x = 3\n\n'
          'Example 2: Factorize x² - 4\n'
          'x² - 4 = x² - 2² = (x + 2)(x - 2)',
          style: TextStyle(fontSize: 16),
        );
      }
    } else {
      // Generic content for other topics
      if (section == 'introduction') {
        return Text(
          'This is an introduction to $topic in $subject. '
          'Here you will learn the basic concepts and principles that form the foundation of this topic.',
          style: const TextStyle(fontSize: 16),
        );
      } else if (section == 'keyPoints') {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('• Key concept 1: Description of key concept 1'),
            SizedBox(height: 8),
            Text('• Key concept 2: Description of key concept 2'),
            SizedBox(height: 8),
            Text('• Key concept 3: Description of key concept 3'),
            SizedBox(height: 8),
            Text('• Key concept 4: Description of key concept 4'),
          ],
        );
      } else {
        // examples
        return Text(
          'Example 1: Description of example 1 related to $topic.\n\n'
          'Example 2: Description of example 2 related to $topic.',
          style: const TextStyle(fontSize: 16),
        );
      }
    }
  }
}
