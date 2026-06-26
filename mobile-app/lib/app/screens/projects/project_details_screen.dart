import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/models/project.dart';
import 'package:intl/intl.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final Project project;

  const ProjectDetailsScreen({super.key, required this.project});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final daysRemaining = project.endDate.difference(DateTime.now()).inDays;
    final progress = _calculateProgress();

    return Scaffold(
      appBar: AppBar(
        title: Text(project.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit project
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showProjectMenu(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.info), text: 'Overview'),
            Tab(icon: Icon(Icons.task), text: 'Tasks'),
            Tab(icon: Icon(Icons.people), text: 'Team'),
            Tab(icon: Icon(Icons.attach_money), text: 'Budget'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(project, daysRemaining, progress),
          _buildTasksTab(),
          _buildTeamTab(),
          _buildBudgetTab(project),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Quick action based on tab
          switch (_tabController.index) {
            case 1: _addTask(); break;
            case 2: _addTeamMember(); break;
            default: _showQuickActions();
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
    );
  }

  Widget _buildOverviewTab(Project project, int daysRemaining, double progress) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Card
          Card(
            color: _getStatusColor(project.status).withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        project.status.toUpperCase(),
                        style: TextStyle(
                          color: _getStatusColor(project.status),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '$daysRemaining days remaining',
                        style: TextStyle(color: AppColors.grey600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColors.grey200,
                    valueColor: AlwaysStoppedAnimation(_getStatusColor(project.status)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${(progress * 100).toStringAsFixed(0)}% Complete',
                    style: TextStyle(color: AppColors.grey600),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Project Details
          _buildInfoSection('Project Information', [
            _buildInfoRow(Icons.location_on, 'Location', project.location),
            _buildInfoRow(Icons.calendar_today, 'Start Date', 
              DateFormat('MMM dd, yyyy').format(project.startDate)),
            _buildInfoRow(Icons.event, 'End Date', 
              DateFormat('MMM dd, yyyy').format(project.endDate)),
            _buildInfoRow(Icons.business, 'Client', project.clientName ?? 'N/A'),
          ]),

          const SizedBox(height: 16),

          // Description
          _buildInfoSection('Description', [
            Text(
              project.description ?? 'No description available',
              style: TextStyle(color: AppColors.grey700, height: 1.5),
            ),
          ]),

          const SizedBox(height: 16),

          // Quick Stats
          Row(
            children: [
              Expanded(child: _buildStatCard('Tasks', '12/24', Icons.task_alt)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard('Team', '8', Icons.people)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard('Materials', '15', Icons.inventory_2)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTasksTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Checkbox(value: index < 5, onChanged: (val) {}),
            title: Text('Task ${index + 1}: Foundation Work'),
            subtitle: Text('Due: ${DateFormat('MMM dd').format(DateTime.now().add(Duration(days: index)))}'),
            trailing: Chip(
              label: Text(index < 5 ? 'Done' : 'Pending'),
              backgroundColor: index < 5 ? AppColors.success.withOpacity(0.2) : AppColors.warning.withOpacity(0.2),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTeamTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 8,
      itemBuilder: (context, index) {
        final roles = ['Project Manager', 'Engineer', 'Foreman', 'Worker', 'Supervisor'];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Text('${String.fromCharCode(65 + index)}', style: const TextStyle(color: Colors.white)),
            ),
            title: Text('Team Member ${index + 1}'),
            subtitle: Text(roles[index % roles.length]),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }

  Widget _buildBudgetTab(Project project) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            color: AppColors.primary.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text('Total Budget', style: TextStyle(color: AppColors.grey600)),
                  const SizedBox(height: 8),
                  Text(
                    'KES ${NumberFormat('#,###').format(project.budget)}',
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('Spent', style: TextStyle(color: AppColors.grey600)),
                          const SizedBox(height: 4),
                          Text('KES 3.2M', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Remaining', style: TextStyle(color: AppColors.grey600)),
                          const SizedBox(height: 4),
                          Text('KES 1.8M', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                </
),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildExpenseItem('Materials', 1500000, 0.6),
          _buildExpenseItem('Labor', 800000, 0.3),
          _buildExpenseItem('Equipment', 500000, 0.2),
          _buildExpenseItem('Miscellaneous', 400000, 0.15),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.grey600),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(color: AppColors.grey600, fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: AppColors.grey600, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseItem(String category, double amount, double percentage) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.secondary.withOpacity(0.2),
          child: Text('${(percentage * 100).toInt()}%'),
        ),
        title: Text(category),
        subtitle: LinearProgressIndicator(
          value: percentage,
          backgroundColor: AppColors.grey200,
        ),
        trailing: Text(
          'KES ${NumberFormat('#,###').format(amount)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active': return AppColors.success;
      case 'planning': return AppColors.info;
      case 'on-hold': return AppColors.warning;
      case 'completed': return AppColors.primary;
      default: return AppColors.grey500;
    }
  }

  double _calculateProgress() {
    final total = widget.project.endDate.difference(widget.project.startDate).inDays;
    final elapsed = DateTime.now().difference(widget.project.startDate).inDays;
    return (elapsed / total).clamp(0.0, 1.0);
  }

  void _showProjectMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Project'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text('Export Report'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: AppColors.error),
            title: const Text('Delete Project', style: TextStyle(color: AppColors.error)),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _addTask() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add task feature coming soon!')),
    );
  }

  void _addTeamMember() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add team member feature coming soon!')),
    );
  }

  void _showQuickActions() {
    // Show quick actions menu
  }
}

