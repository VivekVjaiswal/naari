import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_services.dart';
import 'user_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'login_screen.dart'; // Import the login screen

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({required this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProfile _userProfile;
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _addressController;
  List<TextEditingController> _emergencyContactControllers = [];
  File? _image; // Add this line to store the selected image file

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _addressController = TextEditingController();
    _emergencyContactControllers = [];
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      _userProfile = await FirebaseServices().fetchUserProfile(widget.user);
      _nameController.text = _userProfile.name;
      _phoneNumberController.text = _userProfile.phoneNumber;
      _addressController.text = _userProfile.address;
      for (var contact in _userProfile.emergencyContacts) {
        _emergencyContactControllers
            .add(TextEditingController(text: contact));
      }
      setState(() {});
    } catch (e) {
      print(e.toString());
      // Handle error
    }
  }

  Future<void> _saveUserProfile() async {
    try {
      await FirebaseServices().saveUserProfile(
        widget.user,
        UserProfile(
          name: _nameController.text.trim(),
          phoneNumber: _phoneNumberController.text.trim(),
          address: _addressController.text.trim(),
          emergencyContacts: _emergencyContactControllers
              .map((controller) => controller.text.trim())
              .where((contact) => contact.isNotEmpty)
              .toList(),
        ),
      );
      _fetchUserProfile();
      Navigator.pop(context); // Close the profile screen after saving
    } catch (e) {
      print(e.toString());
      // Handle error
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login', // or the route you want to navigate to after logout
          (route) => false, // This line removes all the routes from the stack
    );
  }

  // Function to open the gallery and pick an image
  Future<void> _pickImage() async {
    final pickedFile =
    await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to add more emergency contact fields
  void _addEmergencyContactField() {
    setState(() {
      _emergencyContactControllers.add(TextEditingController());
    });
  }

  // Function to remove an emergency contact field
  void _removeEmergencyContactField(int index) {
    setState(() {
      _emergencyContactControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveUserProfile,
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout, // Call the logout function here
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image picker button
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              // Display selected image
              _image != null ? Image.file(_image!) : SizedBox.shrink(),
              // Rest of the profile screen UI
              Text('Name:'),
              TextField(controller: _nameController),
              SizedBox(height: 16),
              Text('Phone Number:'),
              TextField(controller: _phoneNumberController),
              SizedBox(height: 16),
              Text('Address:'),
              TextField(controller: _addressController),
              SizedBox(height: 16),
              Text('Emergency Contacts:'),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _emergencyContactControllers.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _emergencyContactControllers[index],
                          decoration:
                          InputDecoration(labelText: 'Contact ${index + 1}'),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          _removeEmergencyContactField(index);
                        },
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addEmergencyContactField,
                child: Text('Add Emergency Contact'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
