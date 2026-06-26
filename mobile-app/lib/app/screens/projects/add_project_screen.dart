import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import 'package:intl/intl.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _clientController = TextEditingController();
  final _budgetController = TextEditingController();
  
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 90));
  String _selectedStatus = 'planning';
  
  final List<String> _statusOptions = ['planning', 'active', 'on-hold', 'completed'];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _clientController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          if (_endDate.isBefore(_startDate)) {
            _endDate = _startDate.add(const Duration(days: 30));
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _saveProject() async {
    if (!_formKey.currentState!.validate()) return;

    final project = {
      'name': _nameController.text,
      'description': _descriptionController.text,
      'location': _locationController.text,
      'client_name': _clientController.text,
      'budget': double.tryParse(_budgetController.text) ?? 0,
      'start_date': _startDate.toIso8601String(),
      'end_date': _endDate.toIso8601String(),
      'status': _selectedStatus,
    };

    // TODO: Save to database via API
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Project created successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pop(context, project);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Project'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProject,
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
              // Project Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Project Name *',
                  prefixIcon: Icon(Icons.business_center),
                  hintText: 'Enter project name',
                ),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              
              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description),
                  hintText: 'Project description',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              
              // Location
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location *',
                  prefixIcon: const Icon(Icons.location_on),
                  hintText: 'Enter project location',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.my_location),
                    onPressed: () {
                      // TODO: Get current location
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Getting current location...')),
                      );
                    },
                  ),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              
              // Client Name
              TextFormField(
                controller: _clientController,
                decoration: const InputDecoration(
                  labelText: 'Client Name',
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Enter client name',
                ),
              ),
              const SizedBox(height: 16),
              
              // Budget
              TextFormField(
                controller: _budgetController,
                decoration: const InputDecoration(
                  labelText: 'Budget (KES)',
                  prefixIcon: Icon(Icons.attach_money),
                  hintText: '0.00',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              
              // Start Date
              InkWell(
                onTap: () => _selectDate(context, true),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Start Date *',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(DateFormat('MMM dd, yyyy').format(_startDate)),
                ),
              ),
              const SizedBox(height: 16),
              
              // End Date
              InkWell(
                onTap: () => _selectDate(context, false),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'End Date *',
                    prefixIcon: Icon(Icons.event),
                  ),
                  child: Text(DateFormat('MMM dd, yyyy').format(_endDate)),
                ),
              ),
              const SizedBox(height: 16),

              // Status
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'Status *',
                  prefixIcon: Icon(Icons.flag),
                ),
                items: _statusOptions.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status[0].toUpperCase() + status.substring(1)),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _selectedStatus = value);
                },
              ),
              const SizedBox(height: 32),

              // Save Button
              SizedBox(
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _saveProject,
                  icon: const Icon(Icons.add),
                  label: const Text('Create Project', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 16),

              // Duration Info
              Card(
                color: AppColors.info.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: AppColors.info),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Project duration: ${_endDate.difference(_startDate).inDays} days',
                          style: const TextStyle(color: AppColors.info),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

