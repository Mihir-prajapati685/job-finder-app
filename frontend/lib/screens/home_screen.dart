import 'package:flutter/material.dart';
import 'package:linkedin_clone/providers/homescreen_post_provider.dart';
import 'package:provider/provider.dart';
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

  bool _isLoading = false;
  bool _isInit = true;
  String? _errorMessage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _fetchPosts();
      _isInit = false;
    }
  }

  Future<void> _fetchPosts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await Provider.of<HomescreenPostProvider>(context, listen: false)
          .fetchPosts();
    } catch (error) {
      _errorMessage = error.toString();
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<HomescreenPostProvider>(context);
    final posts = postProvider.posts;

    final screens = [
      // Home Feed with provider data
      _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text('Error: $_errorMessage'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];

                    // Map your backend fields to your UI fields accordingly:
                    final userName = post['user']['username'] ?? 'Unknown';
                    final headline = post['user']['email'] ?? '';
                    final date = post['createAt'] != null
                        ? post['createAt'].toString().substring(0, 10)
                        : '';
                    final avatar =
                        post['user']['username'][0].toUpperCase() ?? '';
                    final content = post['content'] ?? '';
                    final image = post['url'] ?? '';
                    final likes = post['likes'] ?? 0;
                    final comments = post['comments'] ?? 0;
                    bool liked = post['liked'] ?? false;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      null, // since avatar url not provided in your data
                                  child: Text(post['user']['username'][0]
                                      .toUpperCase()),
                                  radius: 24,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(userName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(headline,
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                      Text(date,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(content),
                            if (image.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: NetworkImage(image),
                              ),
                            ],
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Text('$likes likes',
                                    style: const TextStyle(color: Colors.grey)),
                                const Spacer(),
                                Text('$comments comments',
                                    style: const TextStyle(color: Colors.grey)),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    liked
                                        ? Icons.thumb_up
                                        : Icons.thumb_up_outlined,
                                    color: liked
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      liked = !liked;
                                      post['liked'] = liked;
                                      post['likes'] =
                                          liked ? likes + 1 : likes - 1;
                                    });
                                  },
                                ),
                                const IconButton(
                                  icon: Icon(Icons.comment_outlined,
                                      color: Colors.grey),
                                  onPressed: null,
                                ),
                                const IconButton(
                                  icon: Icon(Icons.share_outlined,
                                      color: Colors.grey),
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
