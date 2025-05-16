import 'package:flutter/material.dart';
import 'package:linkedin_clone/widgets/create_post_card.dart';
import 'profile_screen.dart';
import 'jobs_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> _posts = [];
  bool _isLoadingMore = false;
  int _page = 1;
  final int _limit = 2; // posts per page

  final List<Map<String, dynamic>> _allPosts = [
    // original 3 posts repeated for demonstration
    {
      'userName': 'Michael Chen',
      'headline': 'Product Manager at InnovateTech',
      'date': 'May 14, 2023',
      'avatar': '',
      'content':
          'Just launched our new product after 6 months of hard work. Super proud of the team!',
      'image':
          'https://images.unsplash.com/photo-1519389950473-47ba0277781c?auto=format&fit=crop&w=800&q=80',
      'likes': 87,
      'comments': 15,
      'liked': false,
    },
    {
      'userName': 'Ava Patel',
      'headline': 'UI/UX Designer at Creatives',
      'date': 'May 10, 2023',
      'avatar': '',
      'content': 'Excited to share my latest design project!',
      'image':
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
      'likes': 45,
      'comments': 8,
      'liked': false,
    },
    {
      'userName': 'David Kim',
      'headline': 'Software Engineer at DevWorks',
      'date': 'May 8, 2023',
      'avatar': '',
      'content': 'Attended an amazing tech conference this week!',
      'image':
          'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?auto=format&fit=crop&w=800&q=80',
      'likes': 62,
      'comments': 12,
      'liked': false,
    },
    // Add more mock posts if needed
  ];

  @override
  void initState() {
    super.initState();
    _loadMorePosts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoadingMore) {
        _loadMorePosts();
      }
    });
  }

  void _loadMorePosts() async {
    setState(() => _isLoadingMore = true);

    await Future.delayed(const Duration(seconds: 1)); // simulate loading

    int start = (_page - 1) * _limit;
    int end = start + _limit;
    if (start < _allPosts.length) {
      setState(() {
        _posts.addAll(_allPosts.sublist(start, end.clamp(0, _allPosts.length)));
        _page++;
      });
    }

    setState(() => _isLoadingMore = false);
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      // Home Feed with lazy loading
      ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: _posts.length + 1,
        itemBuilder: (context, index) {
          if (index == _posts.length) {
            return _isLoadingMore
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox.shrink();
          }

          final post = _posts[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: post['avatar'] != ''
                            ? NetworkImage(post['avatar'])
                            : null,
                        child: post['avatar'] == ''
                            ? Text(post['userName'][0])
                            : null,
                        radius: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post['userName'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Text(post['headline'],
                                style: const TextStyle(color: Colors.grey)),
                            Text(post['date'],
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(post['content']),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(post['image'], fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text('${post['likes']} likes',
                          style: const TextStyle(color: Colors.grey)),
                      const Spacer(),
                      Text('${post['comments']} comments',
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                            post['liked']
                                ? Icons.thumb_up
                                : Icons.thumb_up_outlined,
                            color: post['liked']
                                ? Theme.of(context).primaryColor
                                : Colors.grey),
                        onPressed: () {
                          setState(() {
                            post['liked'] = !post['liked'];
                            post['likes'] += post['liked'] ? 1 : -1;
                          });
                        },
                      ),
                      const IconButton(
                        icon: Icon(Icons.comment_outlined, color: Colors.grey),
                        onPressed: null,
                      ),
                      const IconButton(
                        icon: Icon(Icons.share_outlined, color: Colors.grey),
                        onPressed: null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      CreatePostCard(),
      const JobsScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('JobFinder'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search jobs, people, posts...',
                prefixIcon: const Icon(Icons.search),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
        ),
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Post'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Jobs'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
