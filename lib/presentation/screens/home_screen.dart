import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      'Welcome to the Economic Indicators App',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'This application provides a simple way to track and understand key economic indicators from the National Bank of Ethiopia (NBE) 2023/2024 report. Use the navigation below to explore the data.',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Featured Indicators',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildFeaturedCard(
              context,
              title: 'Inflation Rate',
              description:
                  'The recent inflation rate has shown a decreasing trend, but remains a key focus for economic policy.',
            ),
            _buildFeaturedCard(
              context,
              title: 'Real GDP Growth',
              description:
                  'Ethiopia\'s GDP continues to show a strong growth trajectory, driven by key sectors like services and agriculture.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedCard(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(
          Icons.trending_up,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(description),
        ),
      ),
    );
  }
}
