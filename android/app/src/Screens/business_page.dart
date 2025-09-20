import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../auth/auth_controller.dart';
import '../services/storage_service.dart';
import '../services/donation_service.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({super.key});

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _costCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController(text: '1');

  File? _image;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _costCtrl.dispose();
    _qtyCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _image = File(picked.path));
  }

  int _parseInt(String s, {int fallback = 0}) {
    final v = int.tryParse(s.trim());
    return v == null || v < 0 ? fallback : v;
  }

  Future<void> _submit() async {
    final title = _titleCtrl.text.trim();
    final cost = _parseInt(_costCtrl.text, fallback: 0);
    final qty  = _parseInt(_qtyCtrl.text,  fallback: 1);

    if (_image == null || title.isEmpty || cost <= 0 || qty <= 0) {
      setState(() => _error = "Please provide title, positive cost & quantity, and pick an image.");
      return;
    }

    setState(() { _busy = true; _error = null; });

    try {
      final user = context.read<AuthController>().user!;
      final storage = StorageService();
      final donations = DonationService();

      final url = await storage.uploadDonationImage(_image!);
      await donations.createDonation(
        ownerId: user.uid,
        title: title,
        description: _descCtrl.text.trim(),
        photoUrl: url,
        cost: cost,
        quantity: qty,
        type: 'business',
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Business item listed!")),
        );
        _titleCtrl.clear();
        _descCtrl.clear();
        _costCtrl.clear();
        _qtyCtrl.text = '1';
        setState(() => _image = null);
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Business")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _titleCtrl,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: "Item title *"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Description (optional)",
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _costCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Cost (credits) *"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _qtyCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Quantity *"),
                  ),
                ),
              ],
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
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _busy ? null : _submit,
              icon: _busy
                  ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.cloud_upload),
              label: const Text("List Item"),
            ),
          ],
        ),
      ),
    );
  }
}
