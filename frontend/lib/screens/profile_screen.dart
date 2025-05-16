import 'package:flutter/material.dart';
import 'package:linkedin_clone/providers/profile_provider.dart';
import 'package:linkedin_clone/screens/auth/login_screen.dart';
import 'package:linkedin_clone/widgets/showAllpost.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.loadProfileData().then((_) {
      profileProvider.fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      body: profileProvider.username == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Info Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.blue.shade700,
                            child: Text(
                              profileProvider.username!.isNotEmpty
                                  ? profileProvider.username![0].toUpperCase()
                                  : '',
                              style: const TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        _buildEditDialog(context),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: Icon(Icons.edit, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        _buildDeleteDialog(context),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: Icon(Icons.logout_outlined,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ]),
                        Center(
                          child: Text(
                            profileProvider.username ?? 'No Name',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Center(
                          child: Text(
                            profileProvider.headline ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Center(
                          child: Text(
                            '${profileProvider.country ?? ''}, ${profileProvider.city ?? ''}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Center(
                          child: Text(
                            '${profileProvider.link ?? ''},',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Center(
                          child: Text(
                            '${profileProvider.industry ?? ''},',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  const Divider(),

                  // About Section
                  _buildSection('About',
                      profileProvider.about ?? 'Add About your Technologies'),

                  // Experience Section (static or future enhancement)
                  _buildSection('Experience',
                      profileProvider.experience ?? 'Add Experience'),

                  // Education Section
                  _buildSection('Education',
                      profileProvider.education ?? 'Add Education'),

                  // Skills Section
                  _buildSection(
                      'Skills', profileProvider.skills ?? 'Add Skills'),

                  PostsFeed(),
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
              ? (content.trim().isEmpty
                  ? Text(
                      'Add Skills',
                      style: TextStyle(fontSize: 20),
                    ) // kuch bhi show nahi karega jab skills empty ho
                  : Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: content
                          .split(',')
                          .where((skill) =>
                              skill.trim().isNotEmpty) // empty skill hatao
                          .map((skill) => Chip(
                                label: Text(
                                  skill.trim(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.blueAccent,
                              ))
                          .toList(),
                    ))
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

  Widget _buildEditDialog(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    final nameController =
        TextEditingController(text: profileProvider.username ?? '');
    final industryController =
        TextEditingController(text: profileProvider.industry ?? '');
    final skillsController =
        TextEditingController(text: profileProvider.skills ?? '');
    final headlineController =
        TextEditingController(text: profileProvider.headline ?? '');
    final educationController =
        TextEditingController(text: profileProvider.education ?? '');
    final locationController =
        TextEditingController(text: profileProvider.country ?? '');
    final cityController =
        TextEditingController(text: profileProvider.city ?? '');
    final aboutController =
        TextEditingController(text: profileProvider.about ?? '');
    final linkController =
        TextEditingController(text: profileProvider.link ?? '');
    final linkTextController =
        TextEditingController(text: profileProvider.linkText ?? '');
    String selectedPronoun = profileProvider.pronouns ?? 'They/Them';

    final pronouns = ['He/Him', 'She/Her', 'They/Them', 'Other'];
    final experienceController =
        TextEditingController(text: profileProvider.experience ?? '');

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text("Edit intro",
          style: TextStyle(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: headlineController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  hintText: 'Headline',
                  border: OutlineInputBorder(),
                  labelText: "Headline*"),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: industryController,
              decoration: const InputDecoration(
                labelText: 'Industry*',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: skillsController,
              decoration: const InputDecoration(
                labelText: 'Skills*',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Text("Education", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            TextFormField(
              controller: educationController,
              decoration: const InputDecoration(
                labelText: 'School/College*',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Text("Location", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            TextFormField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: 'Country*',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
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
              controller: linkController,
              decoration: const InputDecoration(
                labelText: 'Link',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: linkTextController,
              decoration: const InputDecoration(
                labelText: 'Link Text',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: experienceController,
              decoration: const InputDecoration(
                labelText: 'Experience',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: aboutController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  hintText: 'About',
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
          onPressed: () async {
            // Prepare data from controllers
            Map<String, dynamic> body = {
              "headline": headlineController.text.trim(),
              "skills": skillsController.text.trim(),
              "education": educationController.text.trim(),
              "country": locationController.text.trim(),
              "city": cityController.text.trim(),
              "about": aboutController.text.trim(),
              "pronouns": selectedPronoun,
              "link": linkController.text.trim(),
              "linkText": linkTextController.text.trim(),
              "industry": industryController.text.trim(),
              "experience": experienceController.text.trim()
            };

            await profileProvider.updateProfile(body);
            Navigator.of(context).pop();
          },
          child: const Text("Save"),
        ),
      ],
    );
  }

  Widget _buildDeleteDialog(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    return AlertDialog(
      title: const Text("Logout"),
      content: const Text(
          "If you want to logout then press Yes, or press Cancel to stay."),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () async {
            await profileProvider.deleteprofile(); // Handle logout logic
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          child: const Text("Yes"),
        ),
      ],
    );
  }
}
