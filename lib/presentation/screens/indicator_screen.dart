import '../../data/models/indicator.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:google_fonts/google_fonts.dart';

class IndicatorsScreen extends StatefulWidget {
  final List<Indicator> allIndicators;

  const IndicatorsScreen({super.key, required this.allIndicators});

  @override
  State<IndicatorsScreen> createState() => _IndicatorsScreenState();
}

class _IndicatorsScreenState extends State<IndicatorsScreen> {
  final List<Indicator> _selectedIndicators = [];
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    // Initialize with a default of 5 indicators if available.
    _selectedIndicators.addAll(widget.allIndicators.take(5));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Indicators')),
      body: Column(
        children: [
          _buildIndicatorSelector(context),
          const SizedBox(height: 16),
          Expanded(
            child:
                _selectedIndicators.isEmpty
                    ? Center(
                      child: Text(
                        'Please select up to 5 indicators.',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                    : CarouselSlider.builder(
                      itemCount: _selectedIndicators.length,
                      itemBuilder: (
                        BuildContext context,
                        int itemIndex,
                        int pageViewIndex,
                      ) {
                        return _buildIndicatorCard(
                          _selectedIndicators[itemIndex],
                        );
                      },
                      carouselController: _carouselController,
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                        aspectRatio: 1.0,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {},
                      ),
                    ),
          ),
          const SizedBox(height: 24),
          _buildCarouselButtons(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildIndicatorSelector(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: DropdownButtonFormField<Indicator>(
          dropdownColor: Theme.of(context).scaffoldBackgroundColor,
          isExpanded: true,
          decoration: InputDecoration(
            labelText: 'Select Indicators (Max 5)',
            labelStyle: Theme.of(context).textTheme.bodyLarge,
            border: InputBorder.none,
          ),
          value: null,
          items:
              widget.allIndicators
                  .where(
                    (indicator) => !_selectedIndicators.contains(indicator),
                  )
                  .map<DropdownMenuItem<Indicator>>((Indicator indicator) {
                    return DropdownMenuItem<Indicator>(
                      value: indicator,
                      child: Text(indicator.title),
                    );
                  })
                  .toList(),
          onChanged: (Indicator? newValue) {
            if (newValue != null && _selectedIndicators.length < 5) {
              setState(() {
                _selectedIndicators.add(newValue);
              });
            } else if (newValue != null && _selectedIndicators.length >= 5) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'You can only select a maximum of 5 indicators.',
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildIndicatorCard(Indicator indicator) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              indicator.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child:
                    indicator.isBarChart
                        ? _buildBarChart(indicator)
                        : _buildLineChart(indicator),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              indicator.definition,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(
                  Icons.remove_circle_outline,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndicators.remove(indicator);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart(Indicator indicator) {
    return LineChart(
      LineChartData(
        minX: 2019,
        maxX: 2024,
        minY:
            indicator.data.map((e) => e.value).reduce((a, b) => a < b ? a : b) -
            2,
        maxY:
            indicator.data.map((e) => e.value).reduce((a, b) => a > b ? a : b) +
            2,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  space: 8.0,
                  meta: meta,
                  child: Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 10),
                  textAlign: TextAlign.left,
                );
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots:
                indicator.data
                    .map((e) => FlSpot(e.year.toDouble(), e.value))
                    .toList(),
            isCurved: true,
            color: Theme.of(context).colorScheme.primary,
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(Indicator indicator) {
    return BarChart(
      BarChartData(
        maxY:
            indicator.data.map((e) => e.value).reduce((a, b) => a > b ? a : b) +
            2,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  meta: meta,
                  space: 8.0,
                  child: Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 10),
                  textAlign: TextAlign.left,
                );
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        barGroups:
            indicator.data
                .map(
                  (e) => BarChartGroupData(
                    x: e.year,
                    barRods: [
                      BarChartRodData(
                        toY: e.value,
                        color: Theme.of(context).colorScheme.primary,
                        width: 16,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildCarouselButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 40,
          icon: const Icon(Icons.arrow_left),
          onPressed: () => _carouselController.previousPage(),
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 30),
        IconButton(
          iconSize: 40,
          icon: const Icon(Icons.arrow_right),
          onPressed: () => _carouselController.nextPage(),
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
