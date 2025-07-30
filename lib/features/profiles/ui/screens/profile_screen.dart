import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famconnect/features/familychat/ui/screens/family_chat_screen.dart';
import 'package:famconnect/features/home/ui/screens/home_screen.dart';
import 'package:famconnect/features/home/ui/widgets/bottom_nav_bar_indicator_widget.dart';
import 'package:famconnect/features/setting/ui/screen/settings_screen.dart';
import 'package:famconnect/features/familychat/ui/widgets/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _currentIndex = 3;

  DateTime? _dob;
  bool _isMarried = false;
  DateTime? _anniversary;
  String? _weeklyOff;

  bool isLoading = true;
  UserModel? _userModel;

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();
      final data = doc.data();
      if (data != null) {
        _userModel = UserModel.fromMap(data, userId);
        _nameTEController.text = _userModel!.name;
        _emailTEController.text = _userModel!.email;
        _phoneTEController.text = _userModel!.phone;
        _dob = _userModel!.dob;
        _isMarried = _userModel!.isMarried;
        _anniversary = _userModel!.anniversary;
        _weeklyOff = _userModel!.weeklyOff;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load profile data")),
      );
    }

    setState(() => isLoading = false);
  }

  Future<void> _saveProfile() async {
    try {
      final userModel = UserModel(
        uid: userId,
        name: _nameTEController.text,
        // not editable, so still save
        email: _emailTEController.text,
        phone: _phoneTEController.text,
        dob: _dob,
        isMarried: _isMarried,
        anniversary: _isMarried ? _anniversary : null,
        weeklyOff: _weeklyOff,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update(userModel.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to save profile")));
    }
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
        break;
      case 1:
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const FamilyChatScreen()),
        );
        break;
      case 3:
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SettingsScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: const Text('Profile'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF66B2B2), Color(0xFF66B2B2)],
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(11, 11),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_as_outlined),
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                await _saveProfile();
              }
            },
          ),
        ],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: const [
                          CircleAvatar(radius: 50),
                          //todo: fix code so that image can upload
                          CircleAvatar(
                            radius: 16,
                            child: Icon(Icons.camera_alt, size: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Your Information",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _nameTEController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: "Full Name",
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _phoneTEController,
                        decoration: const InputDecoration(hintText: "Phone"),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailTEController,
                        readOnly: true,
                        decoration: const InputDecoration(hintText: "Email"),
                      ),
                      const SizedBox(height: 10),
                      _datePickerTile(
                        context,
                        label: "Date of Birth",
                        date: _dob,
                        onTap:
                            () => _pickDate(
                              context,
                              (picked) => setState(() => _dob = picked),
                            ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text("Married?"),
                          Switch(
                            value: _isMarried,
                            onChanged:
                                (val) => setState(() => _isMarried = val),
                          ),
                        ],
                      ),
                      _isMarried
                          ? _datePickerTile(
                            context,
                            label: "Anniversary",
                            date: _anniversary,
                            onTap:
                                () => _pickDate(
                                  context,
                                  (picked) =>
                                      setState(() => _anniversary = picked),
                                ),
                          )
                          : const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Marriage Anniversary: No"),
                          ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: "Weekly Day Off",
                        ),
                        value: _weeklyOff,
                        items:
                            const [
                                  "No",
                                  "Monday",
                                  "Tuesday",
                                  "Wednesday",
                                  "Thursday",
                                  "Friday",
                                  "Saturday",
                                  "Sunday",
                                ]
                                .map(
                                  (day) => DropdownMenuItem(
                                    value: day,
                                    child: Text(day),
                                  ),
                                )
                                .toList(),
                        onChanged: (val) => setState(() => _weeklyOff = val),
                      ),
                    ],
                  ),
                ),
              ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: _currentIndex,
        onNavBarTapped: _onNavBarTapped,
      ),
    );
  }

  Widget _datePickerTile(
    BuildContext context, {
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      subtitle: Text(
        date != null ? "${date.day}/${date.month}/${date.year}" : "Select date",
      ),
      trailing: const Icon(Icons.calendar_today),
      onTap: onTap,
    );
  }

  Future<void> _pickDate(
    BuildContext context,
    Function(DateTime) onSelected,
  ) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dob ?? now,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) onSelected(picked);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _nameTEController.dispose();
    _phoneTEController.dispose();
    super.dispose();
  }
}
