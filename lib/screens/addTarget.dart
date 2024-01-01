// ignore_for_file: file_names, camel_case_types, library_private_types_in_public_api, use_build_context_synchronously, unused_element, prefer_null_aware_operators

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qualife_mobileapp/services/firebaseServices.dart';

class addTarget extends StatefulWidget {
  const addTarget({Key? key}) : super(key: key);

  @override
  _addTargetState createState() => _addTargetState();
}

class _addTargetState extends State<addTarget> {
  FirebaseService firebaseService = FirebaseService();
  final TextEditingController _targetTitleController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  String _selectedCategories = 'Sağlık';
  DateTime? _startDate;
  DateTime? _endDate;

  void _submitForm() async {
    String targetTitle = _targetTitleController.text;
    String startDate = _startDate != null
        ? '${_startDate!.day}.${_startDate!.month}.${_startDate!.year}'
        : '';

    String endDate = _endDate != null
        ? '${_endDate!.day}.${_endDate!.month}.${_endDate!.year}'
        : '';
    String categories = _selectedCategories;

    await firebaseService.addTargetToUser(
        targetTitle, startDate, endDate, categories);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Hedef başarıyla eklendi.'),
        duration: Duration(seconds: 3),
      ),
    );
    Navigator.pop(context, true);
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
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null && pickedDate != _startDate) {
                  setState(() {
                    _startDate = pickedDate;
                    _startDateController.text =
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                  });
                }
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _endDateController,
              decoration: const InputDecoration(labelText: 'Bitiş Tarihi'),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null && pickedDate != _endDate) {
                  setState(() {
                    _endDate = pickedDate;
                    _endDateController.text =
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                  });
                }
              },
            ),
            const SizedBox(height: 16.0),
            DropdownButton<String>(
              value: _selectedCategories,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategories = newValue!;
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
              style: ButtonStyle(
                maximumSize: MaterialStateProperty.all<Size>(
                  const Size(100, 40),
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color>(HexColor("#f2f2f2")),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
              ),
              child: const Text(
                'Hedef Ekle',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
