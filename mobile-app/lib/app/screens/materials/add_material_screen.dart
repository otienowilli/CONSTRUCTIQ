import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/materials_database.dart';

class AddMaterialScreen extends StatefulWidget {
  const AddMaterialScreen({super.key});

  @override
  State<AddMaterialScreen> createState() => _AddMaterialScreenState();
}

class _AddMaterialScreenState extends State<AddMaterialScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _densityController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _selectedCategory = 'Cement';
  String _selectedUnit = 'kg';
  
  final List<String> _units = ['kg', 'ton', 'm³', 'L', 'pcs', 'm²', 'm'];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _densityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveMaterial() async {
    if (!_formKey.currentState!.validate()) return;

    final material = {
      'name': _nameController.text,
      'category': _selectedCategory,
      'unit': _selectedUnit,
      'price': double.parse(_priceController.text),
      'density': _densityController.text.isEmpty ? null : double.parse(_densityController.text),
      'description': _descriptionController.text,
    };

    // TODO: Save to database via API
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Material added successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pop(context, material);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Custom Material'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveMaterial,
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
              Card(
                color: AppColors.primary.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: AppColors.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Add any construction material not in our database',
                          style: TextStyle(color: AppColors.grey700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Material Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Material Name *',
                  prefixIcon: Icon(Icons.inventory_2),
                  hintText: 'e.g., Custom Steel Grade XYZ',
                ),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              
              // Category
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category *',
                  prefixIcon: Icon(Icons.category),
                ),
                items: MaterialsDatabase.getAllCategories().map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _selectedCategory = value);
                },
              ),
              const SizedBox(height: 16),
              
              // Unit
              DropdownButtonFormField<String>(
                value: _selectedUnit,
                decoration: const InputDecoration(
                  labelText: 'Unit of Measurement *',
                  prefixIcon: Icon(Icons.straighten),
                ),
                items: _units.map((unit) {
                  return DropdownMenuItem(value: unit, child: Text(unit));
                }).toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _selectedUnit = value);
                },
              ),
              const SizedBox(height: 16),
              
              // Price
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price per Unit (KES) *',
                  prefixIcon: Icon(Icons.attach_money),
                  hintText: 'e.g., 150.00',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (double.tryParse(value) == null) return 'Invalid price';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Density (optional)
              TextFormField(
                controller: _densityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Density (optional)',
                  prefixIcon: Icon(Icons.science),
                  hintText: 'kg/m³',
                ),
              ),
              const SizedBox(height: 16),
              
              // Description
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  prefixIcon: Icon(Icons.description),
                  hintText: 'Additional details about this material',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 32),
              
              // Save Button
              SizedBox(
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _saveMaterial,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Material', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 16),
              
              // Browse Database
              OutlinedButton.icon(
                onPressed: () {
                  _showMaterialsDatabase();
                },
                icon: const Icon(Icons.search),
                label: const Text('Browse Material Database'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMaterialsDatabase() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        builder: (context, scrollController) {
          final allMaterials = MaterialsDatabase.getAllMaterials();
          return Column(
            children: [
              AppBar(
                title: Text('${allMaterials.length}+ Materials Available'),
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: allMaterials.length,
                  itemBuilder: (context, index) {
                    final material = allMaterials[index];
                    return ListTile(
                      title: Text(material['name'] as String),
                      subtitle: Text('${material['category']} - ${material['unit']}'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        _nameController.text = material['name'] as String;
                        _selectedCategory = material['category'] as String;
                        _selectedUnit = material['unit'] as String;
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
