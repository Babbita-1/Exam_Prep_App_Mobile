import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final List<Map<String, dynamic>> subjects = [
    {
      'name': 'Mathematics',
      'icon': Icons.calculate,
      'color': Colors.pink.shade100
    },
    {'name': 'Physics', 'icon': Icons.science, 'color': Colors.pink.shade200},
    {
      'name': 'Chemistry',
      'icon': Icons.science_outlined,
      'color': Colors.pink.shade300
    },
    {'name': 'Biology', 'icon': Icons.biotech, 'color': Colors.pink.shade100},
    {
      'name': 'Computer Science',
      'icon': Icons.computer,
      'color': Colors.pink.shade200
    },
    {'name': 'English', 'icon': Icons.book, 'color': Colors.pink.shade300},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Your Knowledge'),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFeaturedTest(),
              const SizedBox(height: 20),
              const Text(
                'Select Subject',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    return _buildSubjectCard(
                      subjects[index]['name'],
                      subjects[index]['icon'],
                      subjects[index]['color'],
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

  Widget _buildFeaturedTest() {
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
          Row(
            children: [
              const Icon(Icons.star, color: Colors.white),
              const SizedBox(width: 8),
              const Text(
                'Featured Test',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'New',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Full Mock Exam',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Comprehensive test covering all subjects',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              _startTest(context, 'Full Mock Exam');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.pink.shade400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Start Test'),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectCard(String subject, IconData icon, Color color) {
    return InkWell(
      onTap: () {
        _startTest(context, subject);
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: color,
                radius: 25,
                child: Icon(icon, color: Colors.white, size: 25),
              ),
              const SizedBox(height: 10),
              Text(
                subject,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startTest(BuildContext context, String subject) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MCQTestScreen(subject: subject),
      ),
    );
  }
}

class MCQTestScreen extends StatefulWidget {
  final String subject;

  const MCQTestScreen({Key? key, required this.subject}) : super(key: key);

  @override
  State<MCQTestScreen> createState() => _MCQTestScreenState();
}

class _MCQTestScreenState extends State<MCQTestScreen> {
  int _currentQuestionIndex = 0;
  final List<Map<String, dynamic>> _selectedAnswers = [];
  late List<Map<String, dynamic>> _questions;

  @override
  void initState() {
    super.initState();
    // Simulate loading questions based on the subject
    _questions = _getMockQuestions(widget.subject);
    // Initialize selected answers array with nulls
    for (var i = 0; i < _questions.length; i++) {
      _selectedAnswers.add({'selected': null});
    }
  }

  List<Map<String, dynamic>> _getMockQuestions(String subject) {
    // Mock questions for demonstration
    if (subject == 'Mathematics') {
      return [
        {
          'question': 'What is the value of π (pi) to two decimal places?',
          'options': ['3.14', '3.15', '3.16', '3.17'],
          'correctAnswer': 0,
        },
        {
          'question': 'What is the square root of 144?',
          'options': ['12', '14', '10', '16'],
          'correctAnswer': 0,
        },
        {
          'question': 'If x + 5 = 10, what is the value of x?',
          'options': ['5', '15', '0', '10'],
          'correctAnswer': 0,
        },
      ];
    } else if (subject == 'Physics') {
      return [
        {
          'question': 'What is the SI unit of force?',
          'options': ['Newton', 'Joule', 'Watt', 'Pascal'],
          'correctAnswer': 0,
        },
        {
          'question': 'What is the formula for acceleration?',
          'options': ['a = F/m', 'a = v/t', 'a = d/t²', 'a = m/F'],
          'correctAnswer': 0,
        },
      ];
    } else {
      // Generic questions for other subjects
      return [
        {
          'question': 'Sample Question 1 for $subject?',
          'options': ['Option A', 'Option B', 'Option C', 'Option D'],
          'correctAnswer': 0,
        },
        {
          'question': 'Sample Question 2 for $subject?',
          'options': ['Option A', 'Option B', 'Option C', 'Option D'],
          'correctAnswer': 1,
        },
        {
          'question': 'Sample Question 3 for $subject?',
          'options': ['Option A', 'Option B', 'Option C', 'Option D'],
          'correctAnswer': 2,
        },
      ];
    }
  }

  void _selectAnswer(int optionIndex) {
    setState(() {
      _selectedAnswers[_currentQuestionIndex]['selected'] = optionIndex;
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _submitTest() {
    int score = 0;
    for (var i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i]['selected'] == _questions[i]['correctAnswer']) {
        score++;
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Test Results'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your Score: $score/${_questions.length}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Percentage: ${((score / _questions.length) * 100).toStringAsFixed(1)}%',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.pink.shade100,
                child: Text(
                  '$score',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink.shade700),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Reset the test
                setState(() {
                  _currentQuestionIndex = 0;
                  for (var i = 0; i < _selectedAnswers.length; i++) {
                    _selectedAnswers[i]['selected'] = null;
                  }
                });
              },
              child: const Text('Retry'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subject} Test'),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicator
              LinearProgressIndicator(
                value: (_currentQuestionIndex + 1) / _questions.length,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pink.shade300),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
              const SizedBox(height: 10),
              // Question
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    question['question'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Options
              Expanded(
                child: ListView.builder(
                  itemCount: question['options'].length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedAnswers[_currentQuestionIndex]
                            ['selected'] ==
                        index;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: InkWell(
                        onTap: () {
                          _selectAnswer(index);
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: isSelected
                                  ? Colors.pink.shade400
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          color:
                              isSelected ? Colors.pink.shade50 : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected
                                        ? Colors.pink.shade300
                                        : Colors.grey.shade200,
                                  ),
                                  child: Center(
                                    child: Text(
                                      String.fromCharCode(
                                          65 + index), // A, B, C, D
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    question['options'][index],
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Navigation buttons
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Previous button
                    ElevatedButton(
                      onPressed:
                          _currentQuestionIndex > 0 ? _previousQuestion : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.pink.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Previous'),
                    ),
                    // Next or Submit button
                    ElevatedButton(
                      onPressed: _currentQuestionIndex < _questions.length - 1
                          ? _nextQuestion
                          : _submitTest,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        _currentQuestionIndex < _questions.length - 1
                            ? 'Next'
                            : 'Submit',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
