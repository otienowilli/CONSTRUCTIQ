import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../providers/calculator_provider.dart';

class AsphaltCalculatorScreen extends StatefulWidget {
  const AsphaltCalculatorScreen({super.key});

  @override
  State<AsphaltCalculatorScreen> createState() => _AsphaltCalculatorScreenState();
}

class _AsphaltCalculatorScreenState extends State<AsphaltCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();
  final _thicknessController = TextEditingController(text: '50');
  String _selectedType = 'AC14';
  
  final List<String> _asphaltTypes = ['AC10', 'AC14', 'AC20', 'AC25', 'AC30'];

  @override
  void dispose() {
    _lengthController.dispose();
    _widthController.dispose();
    _thicknessController.dispose();
    super.dispose();
  }

  Future<void> _calculate() async {
    if (!_formKey.currentState!.validate()) return;

    final calculatorProvider = Provider.of<CalculatorProvider>(context, listen: false);
    
    await calculatorProvider.calculateAsphalt(
      length: double.parse(_lengthController.text),
      width: double.parse(_widthController.text),
      thickness: double.parse(_thicknessController.text) / 1000, // Convert mm to m
      type: _selectedType,
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
        title: const Text('Asphalt Calculation Results'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildResultRow('Volume', '${result.results['volume']} m³'),
              _buildResultRow('Weight', '${result.results['weight']} tons'),
              _buildResultRow('With Wastage', '${result.results['total_with_wastage']} tons'),
              _buildResultRow('Type', result.results['type']),
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
      appBar: AppBar(title: const Text('Asphalt Calculator')),
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
                          Expanded(child: Text('Calculate asphalt weight and volume for road construction', style: TextStyle(color: AppColors.grey700))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  TextFormField(
                    controller: _lengthController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Length (m)', prefixIcon: Icon(Icons.straighten)),
                    validator: (value) => value == null || value.isEmpty || double.tryParse(value) == null || double.parse(value) <= 0 ? 'Enter valid length' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  TextFormField(
                    controller: _widthController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Width (m)', prefixIcon: Icon(Icons.straighten)),
                    validator: (value) => value == null || value.isEmpty || double.tryParse(value) == null || double.parse(value) <= 0 ? 'Enter valid width' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  TextFormField(
                    controller: _thicknessController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Thickness (mm)', prefixIcon: Icon(Icons.height)),
                    validator: (value) => value == null || value.isEmpty || double.tryParse(value) == null || double.parse(value) <= 0 ? 'Enter valid thickness' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  DropdownButtonFormField<String>(
                    value: _selectedType,
                    decoration: const InputDecoration(labelText: 'Asphalt Type', prefixIcon: Icon(Icons.category)),
                    items: _asphaltTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                    onChanged: (value) {
                      if (value != null) setState(() => _selectedType = value);
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
