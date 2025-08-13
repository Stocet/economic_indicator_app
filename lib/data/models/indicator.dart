class Indicator {
  final int id;
  final String title;
  final String definition;
  final bool isBarChart;
  final List<IndicatorData> data;

  Indicator({
    required this.id,
    required this.title,
    required this.definition,
    required this.isBarChart,
    required this.data,
  });

  factory Indicator.fromJson(Map<String, dynamic> json) {
    return Indicator(
      id: json['id'],
      title: json['title'],
      definition: json['definition'],
      isBarChart: json['isBarChart'],
      data:
          (json['data'] as List)
              .map((item) => IndicatorData.fromJson(item))
              .toList(),
    );
  }
}

class IndicatorData {
  final int year;
  final double value;

  IndicatorData({required this.year, required this.value});

  factory IndicatorData.fromJson(Map<String, dynamic> json) {
    return IndicatorData(year: json['year'], value: json['value'].toDouble());
  }
}
