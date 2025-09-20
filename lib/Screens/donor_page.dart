import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DonorPage extends StatefulWidget {
  const DonorPage({super.key});

  @override
  State<DonorPage> createState() => _DonorPageState();
}

class _DonorPageState extends State<DonorPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _picked;

  Future<void> _pickFromGallery() async {
    final x = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
    if (x == null) return;
    setState(() => _picked = x);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image selected (mock flow)')),
      );
    }
  }

  Future<void> _pickFromCamera() async {
    final x = await _picker.pickImage(source: ImageSource.camera, imageQuality: 75);
    if (x == null) return;
    setState(() => _picked = x);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Photo captured (mock flow)')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = _picked != null;
    return Scaffold(
      appBar: AppBar(title: const Text('Donor Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (hasImage)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(File(_picked!.path), height: 220, fit: BoxFit.cover),
            )
          else
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Icon(Icons.image_outlined, size: 64)),
            ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _pickFromGallery,
            icon: const Icon(Icons.photo_library_outlined),
            label: const Text('Pick from gallery'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _pickFromCamera,
            icon: const Icon(Icons.photo_camera_outlined),
            label: const Text('Take a photo'),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: hasImage
                ? () {
              // later: upload to Firebase Storage, then create Firestore item doc
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mock: Save draft (backend next)')),
              );
            }
                : null,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Save draft'),
          ),
        ],
      ),
    );
  }
}
