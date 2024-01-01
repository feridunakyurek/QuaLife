// ignore_for_file: file_names

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:qualife_mobileapp/services/firebaseServices.dart';

class StatusChart extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();

  StatusChart({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Istatistikler'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 320,
              height: 320,
              child: FutureBuilder(
                future: firebaseService.getTargetsOfCurrentUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  List<Map<String, dynamic>> targetsList =
                      snapshot.data as List<Map<String, dynamic>>;

                  int completedCount = targetsList
                      .where((target) => target['status'] == true)
                      .length;
                  int totalCount = targetsList.length;

                  double completedPercentage = totalCount > 0
                      ? (completedCount / totalCount) * 100
                      : 0.0;
                  double notCompletedPercentage = 100 - completedPercentage;

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PieChart(
                      PieChartData(
                        sections: _buildPieChartSections(
                          completedPercentage,
                          notCompletedPercentage,
                        ),
                        centerSpaceRadius: 120,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tamamlananlar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  'Tamamlanmayanlar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections(
      double completedPercentage, double notCompletedPercentage) {
    List<PieChartSectionData> sections = [];

    sections.add(
      PieChartSectionData(
        color: Colors.green,
        value: completedPercentage,
        title: '${completedPercentage.toStringAsFixed(2)}%',
        radius: 20,
      ),
    );

    sections.add(
      PieChartSectionData(
        color: Colors.red,
        value: notCompletedPercentage,
        title: '${notCompletedPercentage.toStringAsFixed(2)}%',
        radius: 20,
      ),
    );

    return sections;
  }
}
