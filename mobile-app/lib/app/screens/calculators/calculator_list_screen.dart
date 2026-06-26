import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/app_constants.dart';
import 'bitumen_calculator_screen.dart';
import 'asphalt_calculator_screen.dart';
import 'geotextile_calculator_screen.dart';
import 'concrete_calculator_screen.dart';
import 'brickwork_calculator_screen.dart';
import 'plastering_calculator_screen.dart';
import 'painting_calculator_screen.dart';
import 'excavation_calculator_screen.dart';
import 'road_calculator_screen.dart';
import 'roofing_calculator_screen.dart';

class CalculatorListScreen extends StatelessWidget {
  const CalculatorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Calculators'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: AppConstants.calculators.length,
        itemBuilder: (context, index) {
          final calculator = AppConstants.calculators[index];
          return _buildCalculatorCard(context, calculator);
        },
      ),
    );
  }

  Widget _buildCalculatorCard(BuildContext context, Map<String, dynamic> calculator) {
    final id = calculator['id'] as String;
    final name = calculator['name'] as String;
    final icon = calculator['icon'] as String;
    final description = calculator['description'] as String;
    final isNew = calculator['isNew'] as bool? ?? false;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              icon,
              style: const TextStyle(fontSize: 28),
            ),
          ),
        ),
        title: Row(
          children: [
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            if (isNew) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'NEW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            description,
            style: TextStyle(
              color: AppColors.grey600,
              fontSize: 13,
            ),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => _navigateToCalculator(context, id),
      ),
    );
  }

  void _navigateToCalculator(BuildContext context, String calculatorId) {
    Widget? screen;

    switch (calculatorId) {
      case 'concrete':
        screen = const ConcreteCalculatorScreen();
        break;
      case 'bitumen':
        screen = const BitumenCalculatorScreen();
        break;
      case 'asphalt':
        screen = const AsphaltCalculatorScreen();
        break;
      case 'geotextile':
        screen = const GeotextileCalculatorScreen();
        break;
      case 'brickwork':
        screen = const BrickworkCalculatorScreen();
        break;
      case 'plastering':
        screen = const PlasteringCalculatorScreen();
        break;
      case 'painting':
        screen = const PaintingCalculatorScreen();
        break;
      case 'excavation':
        screen = const ExcavationCalculatorScreen();
        break;
      case 'road':
        screen = const RoadCalculatorScreen();
        break;
      case 'roofing':
        screen = const RoofingCalculatorScreen();
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$calculatorId calculator not found!'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen!),
    );
  }
}
