import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

enum ReportUiState { idle, loading, success, empty, error }

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({super.key});

  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  ReportUiState _uiState = ReportUiState.idle;
  bool _simulateFailure = false; // Toggle para sa Error Simulation

  Future<void> _submitReport() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _uiState = ReportUiState.loading);

    try {
      await Future.delayed(const Duration(seconds: 2)); // Async delay

      if (_simulateFailure) {
        throw Exception('Failed to submit report. Please try again.');
      }

      if (!mounted) return;
      setState(() => _uiState = ReportUiState.success);
    } catch (_) {
      if (!mounted) return;
      setState(() => _uiState = ReportUiState.error);
    }
  }

  void _resetForm() {
    setState(() {
      _uiState = ReportUiState.idle;
      _titleController.clear();
      _descController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Report Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    switch (_uiState) {
      // 1. LOADING STATE
      case ReportUiState.loading:
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Submitting report, please wait...'),
            ],
          ),
        );

      // 2. SUCCESS STATE
      case ReportUiState.success:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 64),
              const SizedBox(height: 16),
              const Text(
                'Report Submitted Successfully!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              AppButton(
                text: 'Submit Another Report',
                onPressed: _resetForm,
              ),
            ],
          ),
        );

      // 3. EMPTY STATE
      case ReportUiState.empty:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.inbox, color: Colors.grey, size: 64),
              const SizedBox(height: 16),
              const Text('No Reports Found / List is Empty.'),
              const SizedBox(height: 24),
              AppButton(
                text: 'Back to Form',
                onPressed: () => setState(() => _uiState = ReportUiState.idle),
              ),
            ],
          ),
        );

      // 4. ERROR STATE
      case ReportUiState.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              const Text(
                'An error occurred while submitting.',
                style: TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 24),
              AppButton(
                text: 'Retry Action',
                onPressed: _submitReport,
              ),
            ],
          ),
        );

      // IDLE / FORM STATE (Default)
      case ReportUiState.idle:
      default:
        return Form(
          key: _formKey,
          child: ListView(
            children: [
              AppTextField(
                label: 'Report Title',
                controller: _titleController,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Title is required' : null,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Description',
                controller: _descController,
                validator: (val) => val == null || val.isEmpty
                    ? 'Description is required'
                    : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _simulateFailure,
                    onChanged: (val) =>
                        setState(() => _simulateFailure = val ?? false),
                  ),
                  const Text('Simulate Submission Error'),
                ],
              ),
              const SizedBox(height: 24),
              AppButton(
                text: 'Submit Report',
                onPressed: _submitReport,
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => setState(() => _uiState = ReportUiState.empty),
                child: const Text('View Empty State Demo'),
              ),
            ],
          ),
        );
    }
  }
}