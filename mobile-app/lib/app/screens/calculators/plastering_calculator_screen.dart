import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../providers/calculator_provider.dart';

class PlasteringCalculatorScreen extends StatefulWidget {
  const PlasteringCalculatorScreen({super.key});

  @override
  State<PlasteringCalculatorScreen> createState() => _PlasteringCalculatorScreenState();
}

class _PlasteringCalculatorScreenState extends State<PlasteringCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _lengthController = TextEditingController();
  final _heightController = TextEditingController();
  final _thicknessController = TextEditingController(text: '12');
  String _ratio = '1:4';
  
  final List<String> _ratios = ['1:3', '1:4', '1:5', '1:6'];

  @override
  void dispose() {
    _lengthController.dispose();
    _heightController.dispose();
    _thicknessController.dispose();
    super.dispose();
  }

  Future<void> _calculate() async {
    if (!_formKey.currentState!.validate()) return;

    final calculatorProvider = Provider.of<CalculatorProvider>(context, listen: false);
    
    await calculatorProvider.calculate(
      'plastering',
      {
        'length': double.parse(_lengthController.text),
        'height': double.parse(_heightController.text),
        'thickness': double.parse(_thicknessController.text) / 1000, // mm to m
        'ratio': _ratio,
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
        title: const Text('Plastering Calculation'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildResultRow('Area', '${result.results['area']} m²'),
              _buildResultRow('Cement', '${result.results['cement']} bags'),
              _buildResultRow('Sand', '${result.results['sand']} m³'),
              _buildResultRow('Mix Ratio', result.results['ratio']),
              _buildResultRow('Thickness', '${result.results['thickness']} mm'),
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
      appBar: AppBar(title: const Text('Plastering Calculator')),
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
                    color: AppColors.secondary.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline, color: AppColors.secondary),
                          const SizedBox(width: 12),
                          Expanded(child: Text('Calculate cement and sand for plastering work', style: TextStyle(color: AppColors.grey700))),
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
                    controller: _thicknessController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Plaster Thickness (mm)', prefixIcon: Icon(Icons.format_paint)),
                    validator: (value) => value == null || value.isEmpty || double.tryParse(value) == null || double.parse(value) <= 0 ? 'Enter valid thickness' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  DropdownButtonFormField<String>(
                    value: _ratio,
                    decoration: const InputDecoration(labelText: 'Cement:Sand Ratio', prefixIcon: Icon(Icons.balance)),
                    items: _ratios.map((ratio) => DropdownMenuItem(value: ratio, child: Text(ratio))).toList(),
                    onChanged: (value) {
                      if (value != null) setState(() => _ratio = value);
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
