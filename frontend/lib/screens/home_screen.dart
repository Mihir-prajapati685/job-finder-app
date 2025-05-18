import 'package:flutter/material.dart';
import 'package:linkedin_clone/providers/homescreen_post_provider.dart';
import 'package:linkedin_clone/widgets/openCommentsBottomSheet.dart';
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
    final jobs = postProvider.jobs;

    final combinedList = [...posts, ...jobs];

    final screens = [
      _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text('Error: $_errorMessage'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: combinedList.length,
                  itemBuilder: (context, index) {
                    final item = combinedList[index];

                    // Detect if it's a job (based on jobTitle existence)
                    final isJob = item.containsKey('jobTitle');

                    if (isJob) {
                      // === JOB CARD ===
                      final jobTitle = item['title'] ?? 'No Title';
                      final company = item['company'] ?? 'Unknown';
                      final type = item['type'] ?? 'Type';
                      final location = item['location'] ?? 'Location';
                      final createdAt = item['postedAt'] ?? '';

                      return Card(
                        color: Colors.blue[50],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(jobTitle,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text('$company • $location',
                                  style: const TextStyle(color: Colors.grey)),
                              const SizedBox(height: 4),
                              Chip(
                                label: Text(type),
                                backgroundColor: Colors.blue.shade100,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                  'Posted on ${createdAt.toString().substring(0, 10)}',
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      );
                    } else {
                      // === POST CARD ===
                      final user = item['user'] ?? {};
                      final userName = user['username'] ?? 'Unknown';
                      final headline = user['email'] ?? '';
                      final date = item['createAt'] != null
                          ? item['createAt'].toString().substring(0, 10)
                          : '';
                      final avatar =
                          userName.isNotEmpty ? userName[0].toUpperCase() : '?';
                      final content = item['content'] ?? '';
                      final image = item['url'] ?? '';
                      int likes = item['likes'] ?? 0;
                      final comments = item['comments'] ?? 0;
                      bool liked = item['liked'] ?? false;

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
                                    backgroundColor: Colors.blue.shade100,
                                    child: Text(avatar),
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
                                  child: Image.network(
                                    image,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Text('Image failed to load'),
                                  ),
                                ),
                              ],
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Text('$likes likes',
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                  const Spacer(),
                                  Text('$comments comments',
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                        item['liked'] = liked;
                                        item['likes'] =
                                            liked ? likes + 1 : likes - 1;
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.comment_outlined,
                                        color: Colors.grey),
                                    onPressed: () async {
                                      await openCommentsBottomSheet(
                                          context, item);
                                      setState(
                                          () {}); // Trigger rebuild after bottom sheet is dismissed
                                    },
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
                    }
                  },
                ),
      const CreatePostCard(),
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
              onSubmitted: (value) async {
                final keyword = value.trim();
                if (keyword.isNotEmpty) {
                  setState(() {
                    _isLoading = true;
                    _errorMessage = null;
                  });
                  try {
                    await Provider.of<HomescreenPostProvider>(context,
                            listen: false)
                        .searchPosts(keyword);
                  } catch (e) {
                    setState(() {
                      _errorMessage = e.toString();
                    });
                  }
                  setState(() {
                    _isLoading = false;
                  });
                } else {
                  _fetchPosts(); // reset to full list
                }
              },
              decoration: InputDecoration(
                hintText: 'Search posts or jobs...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _fetchPosts();
                  },
                ),
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
