import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../providers/calculator_provider.dart';

class ConcreteCalculatorScreen extends StatefulWidget {
  const ConcreteCalculatorScreen({super.key});

  @override
  State<ConcreteCalculatorScreen> createState() => _ConcreteCalculatorScreenState();
}

class _ConcreteCalculatorScreenState extends State<ConcreteCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();
  final _depthController = TextEditingController();
  String _selectedGrade = 'C25';
  
  final List<String> _concreteGrades = ['C15', 'C20', 'C25', 'C30', 'C35', 'C40'];

  @override
  void dispose() {
    _lengthController.dispose();
    _widthController.dispose();
    _depthController.dispose();
    super.dispose();
  }

  Future<void> _calculate() async {
    if (!_formKey.currentState!.validate()) return;

    final calculatorProvider = Provider.of<CalculatorProvider>(context, listen: false);
    
    await calculatorProvider.calculateConcrete(
      length: double.parse(_lengthController.text),
      width: double.parse(_widthController.text),
      depth: double.parse(_depthController.text),
      grade: _selectedGrade,
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
        title: const Text('Concrete Calculation'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildResultRow('Volume', '${result.results['volume']} m³'),
              _buildResultRow('Cement', '${result.results['cement']} bags'),
              _buildResultRow('Sand', '${result.results['sand']} m³'),
              _buildResultRow('Aggregate', '${result.results['aggregate']} m³'),
              _buildResultRow('Grade', result.results['grade']),
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
      appBar: AppBar(title: const Text('Concrete Calculator')),
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
                          Expanded(child: Text('Calculate concrete volume and materials required', style: TextStyle(color: AppColors.grey700))),
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
                    controller: _depthController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Depth/Height (m)', prefixIcon: Icon(Icons.height)),
                    validator: (value) => value == null || value.isEmpty || double.tryParse(value) == null || double.parse(value) <= 0 ? 'Enter valid depth' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  DropdownButtonFormField<String>(
                    value: _selectedGrade,
                    decoration: const InputDecoration(labelText: 'Concrete Grade', prefixIcon: Icon(Icons.grade)),
                    items: _concreteGrades.map((grade) => DropdownMenuItem(value: grade, child: Text(grade))).toList(),
                    onChanged: (value) {
                      if (value != null) setState(() => _selectedGrade = value);
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
