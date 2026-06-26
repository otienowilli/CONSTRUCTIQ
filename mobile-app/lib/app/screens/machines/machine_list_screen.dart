import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../providers/machine_provider.dart';

class MachineListScreen extends StatefulWidget {
  const MachineListScreen({super.key});

  @override
  State<MachineListScreen> createState() => _MachineListScreenState();
}

class _MachineListScreenState extends State<MachineListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MachineProvider>(context, listen: false).fetchMachines();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Machines'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<MachineProvider>(context, listen: false).fetchMachines();
            },
          ),
        ],
      ),
      body: Consumer<MachineProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                  const SizedBox(height: 16),
                  Text(provider.error!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.fetchMachines(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (provider.machines.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.precision_manufacturing, size: 64, color: AppColors.grey400),
                  const SizedBox(height: 16),
                  Text('No machines available', style: TextStyle(fontSize: 16, color: AppColors.grey600)),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => provider.fetchMachines(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.machines.length,
              itemBuilder: (context, index) {
                final machine = provider.machines[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: _getMachineStatusColor(machine.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.precision_manufacturing,
                        color: _getMachineStatusColor(machine.status),
                        size: 28,
                      ),
                    ),
                    title: Text(
                      machine.name,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(machine.type, style: TextStyle(color: AppColors.grey600)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              machine.statusIcon,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              machine.status.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: _getMachineStatusColor(machine.status),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      provider.setCurrentMachine(machine);
                      // TODO: Navigate to machine details
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Color _getMachineStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'online':
      case 'running':
        return AppColors.success;
      case 'paused':
        return AppColors.warning;
      case 'offline':
        return AppColors.error;
      default:
        return AppColors.grey500;
    }
  }
}
