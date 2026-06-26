import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/machines_database.dart';
import '../../../core/constants/sensor_codes.dart';

class AddMachineScreen extends StatefulWidget {
  const AddMachineScreen({super.key});

  @override
  State<AddMachineScreen> createState() => _AddMachineScreenState();
}

class _AddMachineScreenState extends State<AddMachineScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _modelController = TextEditingController();
  final _serialController = TextEditingController();
  final _capacityController = TextEditingController();
  
  String _selectedCategory = 'Earthmoving';
  String _selectedPower = 'Diesel';
  List<String> _selectedSensors = [];
  List<Map<String, String>> _customSensors = [];
  
  final List<String> _powerTypes = ['Diesel', 'Electric', 'Petrol', 'Hybrid', 'LPG', 'Battery'];

  @override
  void dispose() {
    _nameController.dispose();
    _modelController.dispose();
    _serialController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  Future<void> _saveMachine() async {
    if (!_formKey.currentState!.validate()) return;

    final machine = {
      'name': _nameController.text,
      'type': _selectedCategory,
      'model': _modelController.text,
      'serial_number': _serialController.text,
      'power': _selectedPower,
      'capacity': _capacityController.text,
      'sensors': [..._selectedSensors, ..._customSensors.map((s) => s['code'])],
      'status': 'offline',
    };

    // TODO: Save to database via API
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Machine added successfully! Connect sensors to start monitoring.'),
          backgroundColor: AppColors.success,
          duration: Duration(seconds: 3),
        ),
      );
      Navigator.pop(context, machine);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Machine'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveMachine,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Info Card
              Card(
                color: AppColors.secondary.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.info_outline, color: AppColors.secondary),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Universal Machine Support',
                              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.grey700),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Add ANY construction machine. System supports all sensor codes as long as sensors are properly installed.',
                        style: TextStyle(color: AppColors.grey600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Machine Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Machine Name *',
                  prefixIcon: Icon(Icons.precision_manufacturing),
                  hintText: 'e.g., CAT Excavator #1',
                ),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              
              // Category
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Machine Category *',
                  prefixIcon: Icon(Icons.category),
                ),
                items: MachinesDatabase.getAllCategories().map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _selectedCategory = value);
                },
              ),
              const SizedBox(height: 16),
              
              // Model
              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(
                  labelText: 'Model/Make',
                  prefixIcon: Icon(Icons.build),
                  hintText: 'e.g., CAT 320D',
                ),
              ),
              const SizedBox(height: 16),
              
              // Serial Number
              TextFormField(
                controller: _serialController,
                decoration: const InputDecoration(
                  labelText: 'Serial Number',
                  prefixIcon: Icon(Icons.qr_code),
                ),
              ),
              const SizedBox(height: 16),
              
              // Power Type
              DropdownButtonFormField<String>(
                value: _selectedPower,
                decoration: const InputDecoration(
                  labelText: 'Power Type *',
                  prefixIcon: Icon(Icons.power),
                ),
                items: _powerTypes.map((power) {
                  return DropdownMenuItem(value: power, child: Text(power));
                }).toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _selectedPower = value);
                },
              ),
              const SizedBox(height: 16),
              
              // Capacity
              TextFormField(
                controller: _capacityController,
                decoration: const InputDecoration(
                  labelText: 'Capacity/Specifications',
                  prefixIcon: Icon(Icons.speed),
                  hintText: 'e.g., 20 ton, 300 HP',
                ),
              ),
              const SizedBox(height: 24),
              
              // Sensors Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Installed Sensors (${_selectedSensors.length + _customSensors.length})',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: _showSensorPicker,
                        icon: const Icon(Icons.sensors, size: 20),
                        label: const Text('Standard'),
                      ),
                      TextButton.icon(
                        onPressed: _showCustomSensorDialog,
                        icon: const Icon(Icons.add, size: 20),
                        label: const Text('Custom'),
                      ),
                    ],
                  ),
                ],
              ),
              if (_selectedSensors.isEmpty && _customSensors.isEmpty)
                Card(
                  color: AppColors.grey100,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.sensors_off, size: 48, color: AppColors.grey400),
                          const SizedBox(height: 8),
                          Text('No sensors added', style: TextStyle(color: AppColors.grey600)),
                          const SizedBox(height: 4),
                          Text('Add standard or custom sensors', style: TextStyle(fontSize: 12, color: AppColors.grey500)),
                        ],
                      ),
                    ),
                  ),
                )
              else
                ..._buildSensorChips(),
              
              const SizedBox(height: 32),
              
              // Save Button
              SizedBox(
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _saveMachine,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Machine', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 16),
              
              // Browse Database
              OutlinedButton.icon(
                onPressed: _showMachinesDatabase,
                icon: const Icon(Icons.search),
                label: const Text('Browse 80+ Machine Types'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSensorChips() {
    return [
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          ..._selectedSensors.map((code) {
            final sensor = SensorCodes.getSensorByCode(code);
            return Chip(
              label: Text(sensor?['code'] ?? code),
              deleteIcon: const Icon(Icons.close, size: 18),
              onDeleted: () {
                setState(() => _selectedSensors.remove(code));
              },
            );
          }),
          ..._customSensors.map((sensor) {
            return Chip(
              label: Text(sensor['code']!),
              backgroundColor: AppColors.secondary.withOpacity(0.2),
              deleteIcon: const Icon(Icons.close, size: 18),
              onDeleted: () {
                setState(() => _customSensors.remove(sensor));
              },
            );
          }),
        ],
      ),
    ];
  }

  void _showSensorPicker() {
    // Implementation continues...
  }

  void _showCustomSensorDialog() {
    // Implementation continues...
  }

  void _showMachinesDatabase() {
    // Implementation continues...
  }
}
