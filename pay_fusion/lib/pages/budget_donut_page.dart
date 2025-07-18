import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pay_fusion/enum/current_view_enum.dart';
import 'package:pay_fusion/main.dart';

class BudgetDonutPage extends StatefulWidget {
  const BudgetDonutPage({super.key});

  @override
  State<BudgetDonutPage> createState() => _BudgetDonutPageState();
}

class _BudgetDonutPageState extends State<BudgetDonutPage> {
  int selectedMonthIndex = 1; // Default: FEB

  final List<String> monthLabels = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
  ];
  final List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
  ];
  final List<double> monthValues = [1300, 3540, 800, 1200, 760, 980, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1115),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Text(
          currentView == CurrentViewEnum.user ? 'Budget' : 'Money Flow',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Donut Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1B1E23),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Budget 2025',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'RM12300.00',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.download, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Donut Chart
                  SizedBox(
                    height: 250,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          PieChartData(
                            sectionsSpace: 4,
                            centerSpaceRadius: 80,
                            startDegreeOffset: -90,
                            sections: _buildChartSections(),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.account_balance_wallet_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'RM${monthValues[selectedMonthIndex].toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              monthNames[selectedMonthIndex],
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Interactive Month Labels
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(monthLabels.length, (index) {
                      final isSelected = index == selectedMonthIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedMonthIndex = index;
                          });
                        },
                        child: Text(
                          monthLabels[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.white38,
                            fontWeight:
                                isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // My Tax Section Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'My Tax',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('See All', style: TextStyle(color: Colors.white70)),
              ],
            ),
            const SizedBox(height: 16),

            // Tax Cards (static for now)
            _taxCard(
              year: '2025',
              amount: 'RM550.00',
              content:
                  'Based on your purchases in February 2025, you are eligible for tax relief on the following categories:',
              items: ['Groceries (RM230)', 'Health Insurance (RM320)'],
            ),
            const SizedBox(height: 16),
            _taxCard(
              year: '2024',
              amount: 'RM150.00',
              content:
                  'Based on your purchases in January 2024, you are eligible for tax relief on the following categories:',
              items: ['Groceries (RM100)', 'Books (RM50)'],
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildChartSections() {
    final colors = [
      Colors.green,
      Colors.lightBlueAccent,
      Colors.purpleAccent,
      Colors.orange,
      Colors.pinkAccent,
      Colors.amberAccent,
      Colors.grey,
      Colors.blueGrey,
    ];

    return List.generate(monthValues.length, (i) {
      return PieChartSectionData(
        value: monthValues[i],
        color: colors[i % colors.length],
        radius: 40,
        showTitle: false,
      );
    });
  }

  static Widget _taxCard({
    required String year,
    required String amount,
    required String content,
    required List<String> items,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2F38),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                year,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                amount,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 8),
          ...items.map(
            (item) =>
                Text('• $item', style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
