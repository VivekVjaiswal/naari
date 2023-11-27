class UserProfile {
  final String name;
  final String phoneNumber;
  final String address;
  final List<String> emergencyContacts;

  UserProfile({
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.emergencyContacts,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'emergencyContacts': emergencyContacts,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      emergencyContacts: List<String>.from(map['emergencyContacts'] ?? []),
    );
  }
}
