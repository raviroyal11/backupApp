import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zob/home/view/blog/blog_details_screen.dart';
import 'package:zob/models/blog_list_api_response_model.dart';
import 'package:zob/services/api_services.dart';
import 'package:zob/utils/app_color.dart';
import 'package:html/parser.dart';

// ─────────────────────────────────────────
// BLOG LIST SCREEN
// ─────────────────────────────────────────
class BlogListScreen extends StatefulWidget {
  const BlogListScreen({super.key});

  @override
  State<BlogListScreen> createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  RxBool isLoading = false.obs;
  RxList<BlogList> blogPosts = <BlogList>[].obs;

  fetchBlogPosts() async {
    isLoading.value = true;
    await Api.blogListApi().then((response) {
      if (response != null) {
        BlogListApiResponseModel blogListApiResponseModel =
            BlogListApiResponseModel.fromJson(response);
        if (blogListApiResponseModel.success == true) {
          blogPosts.value = blogListApiResponseModel.data ?? [];
        }
      }
    });
    isLoading.value = false;
  }

  @override
  void initState() {
    super.initState();
    fetchBlogPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Blog',
          style: TextStyle(
            color: Color(0xFF1A1D3B),
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: Obx(
        () => isLoading.value
            ? const Center(
                child: CircularProgressIndicator(color: AppColor.color77DC))
            : blogPosts.isEmpty
                ? const Center(
                    child: Text(
                      'No blog posts available.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final post = blogPosts[index];
                              return _BlogCard(
                                post: post,
                                onTap: () => Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, anim, __) =>
                                        BlogDetailScreen(slug: post.slug ?? ''),
                                    transitionsBuilder: (_, anim, __, child) =>
                                        SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(1, 0),
                                        end: Offset.zero,
                                      ).animate(CurvedAnimation(
                                          parent: anim,
                                          curve: Curves.easeOutCubic)),
                                      child: child,
                                    ),
                                    transitionDuration:
                                        const Duration(milliseconds: 350),
                                  ),
                                ),
                              );
                            },
                            childCount: blogPosts.length,
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 24)),
                    ],
                  ),
      ),
    );
  }
}

class _BlogCard extends StatelessWidget {
  final BlogList post;
  final VoidCallback onTap;

  const _BlogCard({required this.post, required this.onTap});

  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);

    return document.body?.text
            .replaceAll("\n", " ")
            .replaceAll(RegExp(r'\s+'), ' ')
            .trim() ??
        "";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColor.color77DC.withOpacity(0.08),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  post.image ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFFE8EDFF),
                    child: const Center(
                      child: Icon(Icons.image_rounded,
                          size: 48, color: AppColor.color77DC),
                    ),
                  ),
                  loadingBuilder: (_, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: const Color(0xFFE8EDFF),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.color77DC,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date + Author
                  Row(
                    children: [
                      DateBadge(date: post.createdAt!),
                      const SizedBox(width: 10),
                      Text(
                        'By ',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        post.authorName ?? '',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColor.color77DC,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Title
                  Text(
                    post.title ?? '',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1D3B),
                      height: 1.35,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Excerpt
                  Text(
                    parseHtmlString(post.content ?? ''),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Read More
                  const Row(
                    children: [
                      Text(
                        'Read More',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColor.color77DC,
                          letterSpacing: 0.1,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_rounded,
                          size: 16, color: AppColor.color77DC),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateBadge extends StatelessWidget {
  final DateTime date;
  const DateBadge({required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColor.color77DC,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        DateFormat('MMM dd, yyyy').format(date),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
