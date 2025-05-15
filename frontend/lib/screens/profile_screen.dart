import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Info Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Avatar
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => _buildEditDialog(context),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.edit, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Center(
                    child: Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Center(
                    child: Text(
                      'Software Engineer at Tech Company',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Center(
                    child: Text(
                      'San Francisco, California',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            const Divider(),

            // About Section
            _buildSection(
              'About',
              'Experienced software engineer with a passion for creating innovative solutions. '
                  'Specialized in mobile app development and cloud technologies.',
            ),

            // Experience Section
            _buildSection(
              'Experience',
              'Senior Software Engineer\nTech Company\n2020 - Present\n\n'
                  'Software Engineer\nPrevious Company\n2018 - 2020',
            ),

            // Education Section
            _buildSection(
              'Education',
              'Bachelor of Science in Computer Science\nUniversity of Technology\n2014 - 2018',
            ),

            // Skills Section
            _buildSection(
              'Skills',
              'Flutter • Dart • Firebase • REST APIs • Git • Agile Methodologies',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          title == "Skills"
              ? Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: content
                      .split('•')
                      .map((skill) => Chip(
                            label: Text(
                              skill.trim(),
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 45, 126, 47),
                          ))
                      .toList(),
                )
              : Text(
                  content,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
          const Divider(),
        ],
      ),
    );
  }
}

Widget _buildEditDialog(BuildContext context) {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final additionalNameController = TextEditingController();
  final pronouns = ['He/Him', 'She/Her', 'They/Them', 'Other'];
  String selectedPronoun = 'They/Them';

  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    title:
        const Text("Edit intro", style: TextStyle(fontWeight: FontWeight.bold)),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            maxLines: null, // makes it multiline
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
                hintText: 'Enter your message here',
                border: OutlineInputBorder(),
                labelText: "Headline*"),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: firstNameController,
            decoration: const InputDecoration(
              labelText: 'Industry*',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: lastNameController,
            decoration: const InputDecoration(
              labelText: 'Skills*',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          Text("Education", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          TextFormField(
            controller: additionalNameController,
            decoration: const InputDecoration(
              labelText: 'school/college*',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          Text("Location", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          TextFormField(
            controller: additionalNameController,
            decoration: const InputDecoration(
              labelText: 'Country*',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: additionalNameController,
            decoration: const InputDecoration(
              labelText: 'City',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.info_outline, size: 16),
              const SizedBox(width: 8),
              const Expanded(
                  child: Text(
                      "Name pronunciation can only be added using our mobile app",
                      style: TextStyle(fontSize: 12))),
            ],
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            value: selectedPronoun,
            items: pronouns.map((String pronoun) {
              return DropdownMenuItem<String>(
                value: pronoun,
                child: Text(pronoun),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) selectedPronoun = newValue;
            },
            decoration: const InputDecoration(
              labelText: 'Pronouns',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          Text("Website", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          TextFormField(
            controller: firstNameController,
            decoration: const InputDecoration(
              labelText: 'Link',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: firstNameController,
            decoration: const InputDecoration(
              labelText: 'LinkText',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            maxLines: null, // makes it multiline
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
                hintText: 'Enter your message here',
                border: OutlineInputBorder(),
                labelText: "About"),
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text("Cancel"),
      ),
      ElevatedButton(
        onPressed: () {
          if (firstNameController.text.isNotEmpty &&
              lastNameController.text.isNotEmpty) {
            Navigator.of(context).pop();
            // TODO: Use the values (firstNameController.text, etc.)
          }
        },
        child: const Text("Save"),
      ),
    ],
  );
}
