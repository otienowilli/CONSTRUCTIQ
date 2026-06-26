import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../providers/calculator_provider.dart';

class RoofingCalculatorScreen extends StatefulWidget {
  const RoofingCalculatorScreen({super.key});

  @override
  State<RoofingCalculatorScreen> createState() => _RoofingCalculatorScreenState();
}

class _RoofingCalculatorScreenState extends State<RoofingCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();
  double _roofPitch = 30.0;
  String _roofingType = 'iron_sheets';
  
  final List<String> _roofingTypes = ['iron_sheets', 'tiles', 'shingles', 'concrete'];

  @override
  void dispose() {
    _lengthController.dispose();
    _widthController.dispose();
    super.dispose();
  }

  Future<void> _calculate() async {
    if (!_formKey.currentState!.validate()) return;

    final calculatorProvider = Provider.of<CalculatorProvider>(context, listen: false);
    
    await calculatorProvider.calculate(
      'roofing',
      {
        'length': double.parse(_lengthController.text),
        'width': double.parse(_widthController.text),
        'pitch': _roofPitch,
        'roofing_type': _roofingType,
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
        title: const Text('Roofing Results'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildResultRow('Roof Area', '${result.results['roof_area']} m²'),
              _buildResultRow('Roofing Material', '${result.results['material_quantity']} units'),
              _buildResultRow('Type', result.results['roofing_type']),
              _buildResultRow('Pitch', '${result.results['pitch']}°'),
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
      appBar: AppBar(title: const Text('Roofing Calculator')),
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
                    color: Colors.orange.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.orange[700]),
                          const SizedBox(width: 12),
                          Expanded(child: Text('Calculate roofing materials for your structure', style: TextStyle(color: AppColors.grey700))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  TextFormField(
                    controller: _lengthController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Roof Length (m)', prefixIcon: Icon(Icons.straighten)),
                    validator: (value) => value == null || value.isEmpty || double.tryParse(value) == null || double.parse(value) <= 0 ? 'Enter valid length' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  TextFormField(
                    controller: _widthController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Roof Width (m)', prefixIcon: Icon(Icons.straighten)),
                    validator: (value) => value == null || value.isEmpty || double.tryParse(value) == null || double.parse(value) <= 0 ? 'Enter valid width' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  DropdownButtonFormField<String>(
                    value: _roofingType,
                    decoration: const InputDecoration(labelText: 'Roofing Type', prefixIcon: Icon(Icons.roofing)),
                    items: _roofingTypes.map((type) => DropdownMenuItem(value: type, child: Text(type.replaceAll('_', ' ').toUpperCase()))).toList(),
                    onChanged: (value) {
                      if (value != null) setState(() => _roofingType = value);
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  Text('Roof Pitch: ${_roofPitch.toStringAsFixed(0)}°', style: const TextStyle(fontWeight: FontWeight.w500)),
                  Slider(
                    value: _roofPitch,
                    min: 0,
                    max: 60,
                    divisions: 12,
                    label: '${_roofPitch.toStringAsFixed(0)}°',
                    onChanged: (value) => setState(() => _roofPitch = value),
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
