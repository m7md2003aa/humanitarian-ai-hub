import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class DonorPage extends StatefulWidget {
  const DonorPage({super.key});
  @override
  State<DonorPage> createState() => _DonorPageState();
}

class _DonorPageState extends State<DonorPage> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );
    if (picked != null) setState(() => _imageFile = File(picked.path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donor')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_imageFile != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(_imageFile!, height: 220, fit: BoxFit.cover),
              )
            else
              Container(
                height: 220,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('No image selected'),
              ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.photo),
              label: const Text('Pick Donation Image'),
            ),
            const SizedBox(height: 8),
            const Text('Upload & AI classification will be added after Firebase.'),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNav(current: 0),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int current;
  const _BottomNav({required this.current});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: current,
      onDestinationSelected: (i) {
        if (i == 0) context.go('/donor');
        if (i == 1) context.go('/beneficiary');
        if (i == 2) context.go('/business');
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: 'Donor'),
        NavigationDestination(icon: Icon(Icons.list_alt), selectedIcon: Icon(Icons.list), label: 'Beneficiary'),
        NavigationDestination(icon: Icon(Icons.storefront_outlined), selectedIcon: Icon(Icons.storefront), label: 'Business'),
      ],
    );
  }
}
