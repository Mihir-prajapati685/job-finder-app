import 'package:flutter/material.dart';

class PostsFeed extends StatelessWidget {
  final List<Post> posts = [
    Post(
      name: "Mihir Prajapati",
      role: "Full Stack Developer | Java | Flutter | Spring Boot",
      timeAgo: "1w",
      content:
          "🚀 Just Launched My E-Commerce App! 🛒📱\nI'm excited to share my latest project — a fully functional E-Commerce Application built with Flutter.",
      imageUrl:
          'https://i.imgur.com/8Km9tLL.jpg', // Replace with your image url
      likes: 5,
      comments: 1,
    ),
    Post(
      name: "Mihir Prajapati",
      role: "Full Stack Developer | Java | Flutter | Spring Boot",
      timeAgo: "2w",
      content:
          "I have successfully completed the full Backend Development for a project using Spring Boot! ✅ Built with a clean MVC Architecture.",
      imageUrl:
          'https://i.imgur.com/OW1qILb.png', // Replace with your image url
      likes: 8,
      comments: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title "Activity"
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Text(
            'Activity',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),

        // Horizontal posts list
        Container(
          height: 360,
          padding: EdgeInsets.symmetric(vertical: 12),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12),
            itemCount: posts.length,
            separatorBuilder: (_, __) => SizedBox(width: 12),
            itemBuilder: (context, index) {
              final post = posts[index];
              return PostCard(post: post);
            },
          ),
        ),
      ],
    );
  }
}

// Post and PostCard classes remain the same
class Post {
  final String name;
  final String role;
  final String timeAgo;
  final String content;
  final String imageUrl;
  final int likes;
  final int comments;

  Post({
    required this.name,
    required this.role,
    required this.timeAgo,
    required this.content,
    required this.imageUrl,
    required this.likes,
    required this.comments,
  });
}

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3)],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage('https://i.pravatar.cc/150?u=${post.name}'),
                  radius: 22,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(post.role,
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      SizedBox(height: 4),
                      Text(post.timeAgo + " • 🌐",
                          style: TextStyle(
                              color: Colors.grey.shade500, fontSize: 11)),
                    ],
                  ),
                ),
                Icon(Icons.more_horiz),
              ],
            ),
            SizedBox(height: 10),
            Text(
              post.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.network(
                  post.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      Center(child: Icon(Icons.broken_image)),
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                Icon(Icons.thumb_up_alt_outlined,
                    size: 16, color: Colors.grey.shade600),
                SizedBox(width: 4),
                Text('${post.likes}'),
                SizedBox(width: 16),
                Icon(Icons.comment_outlined,
                    size: 16, color: Colors.grey.shade600),
                SizedBox(width: 4),
                Text('${post.comments}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
