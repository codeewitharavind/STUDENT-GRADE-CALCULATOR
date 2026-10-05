import 'package:flutter/material.dart';

void main() => runApp(const GradeApp());

class GradeApp extends StatelessWidget {
  const GradeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grade Calculator',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const GradeCalculator(),
    );
  }
}

class GradeCalculator extends StatefulWidget {
  const GradeCalculator({super.key});

  @override
  State<GradeCalculator> createState() => _GradeCalculatorState();
}

class _GradeCalculatorState extends State<GradeCalculator> {
  final name = TextEditingController();
  final marks = List.generate(5, (_) => TextEditingController());
  final subjects = ['Maths', 'Physics', 'Chemistry', 'Computer', 'English'];

  double total = 0, percentage = 0, average = 0;
  String grade = '-', result = '-';

  void calculate() {
    final values = marks.map((e) => double.tryParse(e.text) ?? -1).toList();

    if (values.any((m) => m < 0 || m > 100)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter marks between 0 and 100')),
      );
      return;
    }

    total = values.reduce((a, b) => a + b);
    average = total / 5;
    percentage = total / 5;
    final pass = values.every((m) => m >= 35);

    if (!pass) {
      grade = 'F';
      result = 'FAIL';
    } else if (percentage >= 90) {
      grade = 'A+';
      result = 'PASS';
    } else if (percentage >= 80) {
      grade = 'A';
      result = 'PASS';
    } else if (percentage >= 70) {
      grade = 'B';
      result = 'PASS';
    } else if (percentage >= 60) {
      grade = 'C';
      result = 'PASS';
    } else if (percentage >= 50) {
      grade = 'D';
      result = 'PASS';
    } else {
      grade = 'E';
      result = 'PASS';
    }

    setState(() {});
  }

  void reset() {
    name.clear();
    for (final m in marks) m.clear();
    setState(() {
      total = 0;
      average = 0;
      percentage = 0;
      grade = '-';
      result = '-';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Grade Calculator'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(
                labelText: 'Student Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            ...List.generate(
              5,
              (i) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TextField(
                  controller: marks[i],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: subjects[i],
                    suffixText: '/ 100',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: calculate,
                    child: const Text('Calculate'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: reset,
                    child: const Text('Reset'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      name.text.isEmpty ? 'Result' : name.text,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text('Total Marks: ${total.toStringAsFixed(1)} / 500'),
                    Text('Average: ${average.toStringAsFixed(2)}'),
                    Text('Percentage: ${percentage.toStringAsFixed(2)}%'),
                    Text('Grade: $grade'),
                    const SizedBox(height: 10),
                    Text(
                      result,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: result == 'PASS' ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
