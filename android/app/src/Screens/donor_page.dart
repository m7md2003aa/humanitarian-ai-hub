import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../auth/auth_controller.dart';
import '../services/storage_service.dart';
import '../services/donation_service.dart';

class DonorPage extends StatefulWidget {
  const DonorPage({super.key});

  @override
  State<DonorPage> createState() => _DonorPageState();
}

class _DonorPageState extends State<DonorPage> {
  final _titleController = TextEditingController();
  final _costController = TextEditingController();
  File? _image;
  bool _busy = false;
  String? _error;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _image = File(picked.path));
  }

  Future<void> _submit() async {
    if (_image == null || _titleController.text.isEmpty || _costController.text.isEmpty) {
      setState(() => _error = "Please fill all fields and pick an image");
      return;
    }

    setState(() { _busy = true; _error = null; });

    try {
      final user = context.read<AuthController>().user!;
      final storage = StorageService();
      final donation = DonationService();

      final url = await storage.uploadDonationImage(_image!);
      await donation.createDonation(
        ownerId: user.uid,
        title: _titleController.text.trim(),
        photoUrl: url,
        cost: int.tryParse(_costController.text.trim()) ?? 0,
        type: "donor",
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Donation uploaded!")));
        _titleController.clear();
        _costController.clear();
        setState(() => _image = null);
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _costController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Donor")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: "Item title"),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _costController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Cost (credits)"),
          ),
          const SizedBox(height: 12),
          if (_image != null)
            Image.file(_image!, height: 180)
          else
            TextButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text("Pick Image"),
            ),
          const SizedBox(height: 16),
          if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _busy ? null : _submit,
            icon: _busy
                ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.cloud_upload),
            label: const Text("Upload Donation"),
          ),
        ]),
      ),
    );
  }
}
