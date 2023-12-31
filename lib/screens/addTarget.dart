// ignore_for_file: file_names, camel_case_types, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:qualife_mobileapp/services/firebaseServices.dart';

class addTarget extends StatefulWidget {
  const addTarget({super.key});

  @override
  _addTargetState createState() => _addTargetState();
}

class _addTargetState extends State<addTarget> {
  FirebaseService firebaseService = FirebaseService();
  final TextEditingController _targetTitleController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  String _selectedCategory = 'Sağlık'; // Default olarak 'Sağlık' seçili

  void _submitForm() async {
    String targetTitle = _targetTitleController.text;
    String startDate = _startDateController.text;
    String endDate = _endDateController.text;
    String category = _selectedCategory;

    await firebaseService.addTargetToUser(
        targetTitle, startDate, endDate, category);

    // Başarıyla eklendi bildirimini göster
    Flushbar(
      message: 'Başarıyla Eklendi!',
      duration: const Duration(seconds: 3),
    ).show(context);

    // Ana sayfaya geri dön
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hedef Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _targetTitleController,
              decoration: const InputDecoration(labelText: 'Hedef Adı'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _startDateController,
              decoration: const InputDecoration(labelText: 'Başlangıç Tarihi'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _endDateController,
              decoration: const InputDecoration(labelText: 'Bitiş Tarihi'),
            ),
            const SizedBox(height: 16.0),
            DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: <String>['Sağlık', 'Günlük', 'Aylık']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}
