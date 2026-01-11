import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../state/providers/split_providers.dart';
import '../widgets/frosted_card.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final splits = ref.watch(splitsProvider);
    
    // Calculate total spending (sum of all split totals)
    final totalSpending = splits.fold<double>(
      0,
      (sum, split) => sum + split.items.fold(0, (s, i) => s + i.price),
    );

    // Prepare data for chart (Last 7 splits or all if less)
    final sortedSplits = List.from(splits)..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    final chartData = sortedSplits.take(7).toList();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Total Spending Card
            FrostedCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    'Total Tracked Spending',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${totalSpending.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Chart Title
            Text(
              'Recent Splits',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            if (chartData.isEmpty)
              const Center(child: Text("No data for charts"))
            else
              SizedBox(
                height: 300,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: chartData.isEmpty ? 100 : chartData.map((s) => s.items.fold<double>(0, (sum, i) => sum + i.price)).reduce((a, b) => a > b ? a : b) * 1.2,
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            if (value.toInt() >= 0 && value.toInt() < chartData.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  '${chartData[value.toInt()].createdAt.day}/${chartData[value.toInt()].createdAt.month}',
                                  style: const TextStyle(fontSize: 10),
                                ),
                              );
                            }
                            return const Text('');
                          },
                        ),
                      ),
                      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(show: false),
                    barGroups: chartData.asMap().entries.map((entry) {
                      final index = entry.key;
                      final split = entry.value;
                      final total = split.items.fold<double>(0, (sum, i) => sum + i.price);
                      
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: total,
                            color: Theme.of(context).colorScheme.primary,
                            width: 16,
                            borderRadius: BorderRadius.circular(4),
                            backDrawRodData: BackgroundBarChartRodData(
                              show: true,
                              toY: chartData.map((s) => s.items.fold<double>(0, (sum, i) => sum + i.price)).reduce((a, b) => a > b ? a : b) * 1.2,
                              color: Theme.of(context).colorScheme.surfaceContainerHighest,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
