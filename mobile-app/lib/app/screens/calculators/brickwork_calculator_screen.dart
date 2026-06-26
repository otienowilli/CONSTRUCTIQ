import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../providers/calculator_provider.dart';

class BrickworkCalculatorScreen extends StatefulWidget {
  const BrickworkCalculatorScreen({super.key});

  @override
  State<BrickworkCalculatorScreen> createState() => _BrickworkCalculatorScreenState();
}

class _BrickworkCalculatorScreenState extends State<BrickworkCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _lengthController = TextEditingController();
  final _heightController = TextEditingController();
  final _wallThicknessController = TextEditingController(text: '0.23');
  String _brickSize = 'standard';
  
  final List<Map<String, String>> _brickSizes = [
    {'value': 'standard', 'label': 'Standard (230x115x75mm)'},
    {'value': 'modular', 'label': 'Modular (190x90x90mm)'},
    {'value': 'king', 'label': 'King Size (230x115x90mm)'},
  ];

  @override
  void dispose() {
    _lengthController.dispose();
    _heightController.dispose();
    _wallThicknessController.dispose();
    super.dispose();
  }

  Future<void> _calculate() async {
    if (!_formKey.currentState!.validate()) return;

    final calculatorProvider = Provider.of<CalculatorProvider>(context, listen: false);
    
    await calculatorProvider.calculate(
      'brickwork',
      {
        'length': double.parse(_lengthController.text),
        'height': double.parse(_heightController.text),
        'wall_thickness': double.parse(_wallThicknessController.text),
        'brick_size': _brickSize,
      },
    );

    if (mounted && calculatorProvider.error == null) {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    final result = Provider.of<CalculatorProvider>(context, listen: false).currentResult;
    if (result == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Brickwork Calculation'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildResultRow('Wall Area', '${result.results['area']} m²'),
              _buildResultRow('Bricks Required', '${result.results['bricks']} pcs'),
              _buildResultRow('Cement', '${result.results['cement']} bags'),
              _buildResultRow('Sand', '${result.results['sand']} m³'),
              _buildResultRow('Brick Size', result.results['brick_size']),
              const Divider(height: 24),
              _buildResultRow('Total Cost', result.formattedCost, bold: true),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Save')),
        ],
      ),
    );
  }

  Widget _buildResultRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: AppColors.grey600)),
          Text(value, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal, fontSize: bold ? 18 : 14)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Brickwork Calculator')),
      body: Consumer<CalculatorProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    color: AppColors.primary.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline, color: AppColors.primary),
                          const SizedBox(width: 12),
                          Expanded(child: Text('Calculate bricks, cement and sand for wall construction', style: TextStyle(color: AppColors.grey700))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  TextFormField(
                    controller: _lengthController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Wall Length (m)', prefixIcon: Icon(Icons.straighten)),
                    validator: (value) => value == null || value.isEmpty || double.tryParse(value) == null || double.parse(value) <= 0 ? 'Enter valid length' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  TextFormField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Wall Height (m)', prefixIcon: Icon(Icons.height)),
                    validator: (value) => value == null || value.isEmpty || double.tryParse(value) == null || double.parse(value) <= 0 ? 'Enter valid height' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  TextFormField(
                    controller: _wallThicknessController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Wall Thickness (m)', prefixIcon: Icon(Icons.width_full)),
                    validator: (value) => value == null || value.isEmpty || double.tryParse(value) == null || double.parse(value) <= 0 ? 'Enter valid thickness' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  DropdownButtonFormField<String>(
                    value: _brickSize,
                    decoration: const InputDecoration(labelText: 'Brick Size', prefixIcon: Icon(Icons.view_module)),
                    items: _brickSizes.map((size) => DropdownMenuItem(value: size['value'], child: Text(size['label']!))).toList(),
                    onChanged: (value) {
                      if (value != null) setState(() => _brickSize = value);
                    },
                  ),
                  const SizedBox(height: 32),
                  
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: provider.isLoading ? null : _calculate,
                      child: provider.isLoading
                          ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                          : const Text('Calculate', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
