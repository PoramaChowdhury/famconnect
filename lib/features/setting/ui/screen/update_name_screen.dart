
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:famconnect/features/common/ui/widgets/custom_snakebar.dart';
import 'package:flutter/material.dart';

class UpdateNameScreen extends StatefulWidget {
  const UpdateNameScreen({super.key});
  static const String name = '/update-name-screen';

  @override
  State<UpdateNameScreen> createState() => _UpdateNameScreenState();
}

class _UpdateNameScreenState extends State<UpdateNameScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final String _userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _loadCurrentName();
  }

  /// Load name from 'users' collection in Firestore
  Future<void> _loadCurrentName() async {
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(_userId).get();
      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          _firstNameTEController.text = data['name'] ?? '';
        }
      }
    } catch (e) {
      showSnackBarMessage(context, "Error loading name: $e", true);
    }
  }

  /// Update name in Firestore
  Future<void> _updateName() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final updatedName = _firstNameTEController.text.trim();

      await FirebaseFirestore.instance.collection('users').doc(_userId).update({
        'name': updatedName,
      });

      showSnackBarMessage(context, "Name updated successfully.");
      Navigator.pop(context); // Go back to Profile or Settings
    } catch (e) {
      showSnackBarMessage(context, "Failed to update name: $e", true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Name'),
        centerTitle: true,
        backgroundColor: const Color(0xFF66B2B2),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _firstNameTEController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _updateName,
              child: const Text('Update Name'),
            ),
          ],
        ),
      ),
    );
  }
}
