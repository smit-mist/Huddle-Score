class Captain {
  final int contact;
  final int age;
  final String email;
  final String fullName;
  const Captain({
    this.contact = 373737,
    this.age = 37,
    this.email = "nomail@mail.com",
    this.fullName = "No Name",
  });
  factory Captain.fromMap(Map<String, dynamic> doc) => Captain(
        contact: doc['contact'] ?? 37,
        age: doc['age'] ?? 37,
        email: doc['email'] ?? 'NOT FOUND',
        fullName: doc['name'] ?? 'NOT FOUND',
      );
  Map<String, dynamic> toMap(Captain captain) {
    return <String, dynamic>{
      'contact': captain.contact,
      'age': captain.age,
      'email': captain.email,
      'name': captain.fullName,
    };
  }
}
