// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import '../providers/profile_provider.dart';

// // class ProfileHeader extends StatelessWidget {
// //   final String name;
// //   final String headline;
// //   final String avatar;
// //   final String location;
// //   final bool isOwnProfile;

// //   const ProfileHeader({
// //     super.key,
// //     required this.name,
// //     required this.headline,
// //     required this.avatar,
// //     required this.location,
// //     required this.isOwnProfile,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.all(16),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             children: [
// //               CircleAvatar(
// //                 radius: 40,
// //                 backgroundImage: avatar.isNotEmpty
// //                     ? NetworkImage(avatar)
// //                     : null,
// //                 child: avatar.isEmpty
// //                     ? const Icon(Icons.person, size: 40)
// //                     : null,
// //               ),
// //               const SizedBox(width: 16),
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       name,
// //                       style: Theme.of(context).textTheme.headlineSmall,
// //                     ),
// //                     const SizedBox(height: 4),
// //                     Text(
// //                       headline,
// //                       style: Theme.of(context).textTheme.bodyLarge,
// //                     ),
// //                     const SizedBox(height: 4),
// //                     Text(
// //                       location,
// //                       style: Theme.of(context).textTheme.bodyMedium,
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class AboutSection extends StatelessWidget {
// //   final String about;
// //   final bool isOwnProfile;

// //   const AboutSection({
// //     super.key,
// //     required this.about,
// //     required this.isOwnProfile,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.all(16),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Text(
// //                 'About',
// //                 style: Theme.of(context).textTheme.titleLarge,
// //               ),
// //               if (isOwnProfile)
// //                 IconButton(
// //                   icon: const Icon(Icons.edit),
// //                   onPressed: () {
// //                     // TODO: Implement edit functionality
// //                   },
// //                 ),
// //             ],
// //           ),
// //           const SizedBox(height: 8),
// //           Text(
// //             about,
// //             style: Theme.of(context).textTheme.bodyMedium,
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class SkillsSection extends StatelessWidget {
// //   final List<String> skills;
// //   final bool isOwnProfile;

// //   const SkillsSection({
// //     super.key,
// //     required this.skills,
// //     required this.isOwnProfile,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.all(16),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Text(
// //                 'Skills',
// //                 style: Theme.of(context).textTheme.titleLarge,
// //               ),
// //               if (isOwnProfile)
// //                 IconButton(
// //                   icon: const Icon(Icons.edit),
// //                   onPressed: () {
// //                     // TODO: Implement edit functionality
// //                   },
// //                 ),
// //             ],
// //           ),
// //           const SizedBox(height: 8),
// //           Wrap(
// //             spacing: 8,
// //             runSpacing: 8,
// //             children: skills.map((skill) {
// //               return Chip(
// //                 label: Text(skill),
// //                 backgroundColor: Theme.of(context).colorScheme.primaryContainer,
// //                 labelStyle: TextStyle(
// //                   color: Theme.of(context).colorScheme.onPrimaryContainer,
// //                 ),
// //               );
// //             }).toList(),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // } 

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/profile_provider.dart';

// class ProfileHeader extends StatelessWidget {
//   final String name;
//   final String headline;
//   final String avatar;
//   final String location;
//   final bool isOwnProfile;

//   const ProfileHeader({
//     super.key,
//     required this.name,
//     required this.headline,
//     required this.avatar,
//     required this.location,
//     required this.isOwnProfile,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 radius: 40,
//                 backgroundImage: avatar.isNotEmpty
//                     ? NetworkImage(avatar)
//                     : null,
//                 child: avatar.isEmpty
//                     ? const Icon(Icons.person, size: 40)
//                     : null,
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       name,
//                       style: Theme.of(context).textTheme.headlineSmall,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       headline,
//                       style: Theme.of(context).textTheme.bodyLarge,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       location,
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AboutSection extends StatelessWidget {
//   final String about;
//   final bool isOwnProfile;

//   const AboutSection({
//     super.key,
//     required this.about,
//     required this.isOwnProfile,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'About',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//               if (isOwnProfile)
//                 IconButton(
//                   icon: const Icon(Icons.edit),
//                   onPressed: () {
//                     // TODO: Implement edit functionality
//                   },
//                 ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(
//             about,
//             style: Theme.of(context).textTheme.bodyMedium,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SkillsSection extends StatelessWidget {
//   final List<String> skills;
//   final bool isOwnProfile;

//   const SkillsSection({
//     super.key,
//     required this.skills,
//     required this.isOwnProfile,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Skills',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//               if (isOwnProfile)
//                 IconButton(
//                   icon: const Icon(Icons.edit),
//                   onPressed: () {
//                     // TODO: Implement edit functionality
//                   },
//                 ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             children: skills.map((skill) {
//               return Chip(
//                 label: Text(skill),
//                 backgroundColor: Theme.of(context).colorScheme.primaryContainer,
//                 labelStyle: TextStyle(
//                   color: Theme.of(context).colorScheme.onPrimaryContainer,
//                 ),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CreatePostPage extends StatelessWidget {
//   final TextEditingController _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Create Post')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _controller,
//               maxLines: 5,
//               decoration: InputDecoration(
//                 hintText: "What's on your mind?",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Send post logic here
//                 final postContent = _controller.text;
//                 // Call your provider or API to send the post
//               },
//               child: Text('Post'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }