import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:zob/home/view/blog/blog_screen.dart';
import 'package:zob/models/BlogDetailsApiResponseModel.dart';
import 'package:zob/models/blog_list_api_response_model.dart';
import 'package:zob/services/api_services.dart';
import 'package:zob/utils/app_color.dart';
import 'package:html/parser.dart';

class BlogDetailScreen extends StatefulWidget {
  final String slug;
  const BlogDetailScreen({super.key, required this.slug});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0;
  RxBool isLoading = false.obs;
  Rxn<BlogDetailsData> blogDetails = Rxn<BlogDetailsData>();

  ///// Blog details api call
  fetchBlogDetails(String slug) async {
    isLoading.value = true;
    await Api.blogDetailsApis(blogSlug: slug).then((response) {
      if (response != null) {
        BlogDetailsApiResponseModel blogDetailsApiResponseModel =
            BlogDetailsApiResponseModel.fromJson(response);
        if (blogDetailsApiResponseModel.success == true) {
          blogDetails.value = blogDetailsApiResponseModel.data;
        }
        isLoading.value = false;
      }
      isLoading.value = false;
    });
    isLoading.value = false;
  }

  @override
  void initState() {
    super.initState();
    fetchBlogDetails(widget.slug);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent > 0) {
        setState(() {
          _scrollProgress = (_scrollController.offset /
                  _scrollController.position.maxScrollExtent)
              .clamp(0.0, 1.0);
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: Obx(
        () => isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColor.color77DC,
                ),
              )
            : Stack(
                children: [
                  CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      // Collapsible App Bar with Hero Image
                      SliverAppBar(
                        expandedHeight: 280,
                        pinned: true,
                        backgroundColor: Colors.white,
                        elevation: 0,
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 8,
                                  )
                                ],
                              ),
                              child: const Icon(Icons.arrow_back_rounded,
                                  color: Color(0xFF1A1D3B), size: 20),
                            ),
                          ),
                        ),
                        // actions: [
                        //   Padding(
                        //     padding: const EdgeInsets.all(8),
                        //     child: GestureDetector(
                        //       onTap: () =>
                        //           setState(() => _isBookmarked = !_isBookmarked),
                        //       child: Container(
                        //         padding: const EdgeInsets.all(8),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           shape: BoxShape.circle,
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.black.withOpacity(0.15),
                        //               blurRadius: 8,
                        //             )
                        //           ],
                        //         ),
                        //         child: Icon(
                        //           _isBookmarked
                        //               ? Icons.bookmark_rounded
                        //               : Icons.bookmark_border_rounded,
                        //           color: _isBookmarked
                        //               ? AppColor.color77DC
                        //               : const Color(0xFF1A1D3B),
                        //           size: 20,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        //   Padding(
                        //     padding:
                        //         const EdgeInsets.only(right: 12, top: 8, bottom: 8),
                        //     child: Container(
                        //       padding: const EdgeInsets.all(8),
                        //       decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         shape: BoxShape.circle,
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.black.withOpacity(0.15),
                        //             blurRadius: 8,
                        //           )
                        //         ],
                        //       ),
                        //       child: const Icon(Icons.share_rounded,
                        //           color: Color(0xFF1A1D3B), size: 20),
                        //     ),
                        //   ),
                        // ],
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                blogDetails.value?.image ?? '',
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: const Color(0xFFE8EDFF),
                                ),
                              ),
                              // Gradient overlay
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.4),
                                    ],
                                  ),
                                ),
                              ),
                              // Category badge on image
                              Positioned(
                                bottom: 16,
                                left: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColor.color77DC,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    blogDetails
                                            .value?.manageBlogCategory?.title ??
                                        '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Content
                      SliverToBoxAdapter(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(28)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 28, 16, 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Date + Author row
                                Row(
                                  children: [
                                    DateBadge(
                                        date: blogDetails.value!.createdAt!),
                                    const SizedBox(width: 10),
                                    Text(
                                      'By ',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                    Text(
                                      blogDetails.value?.authorName ?? '',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColor.color77DC,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                // Title
                                Text(
                                  blogDetails.value?.title ?? '',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1A1D3B),
                                    height: 1.3,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Article body
                                // ...widget.post.content!.split('\n\n').map((paragraph) {
                                //   if (paragraph.trim().isEmpty)
                                //     return const SizedBox.shrink();
                                //   return Padding(
                                //     padding: const EdgeInsets.only(bottom: 16),
                                //     child: Text(
                                //       paragraph.trim(),
                                //       style: TextStyle(
                                //         fontSize: 15.5,
                                //         color: Colors.grey.shade800,
                                //         height: 1.75,
                                //         letterSpacing: 0.1,
                                //       ),
                                //     ),
                                //   );
                                // }),

                                Html(
                                  data: HtmlUnescape().convert(
                                      blogDetails.value?.content ?? ''),
                                  style: {
                                    "*": Style(
                                      // 👈 sab par apply hoga
                                      fontSize: FontSize(15),
                                    ),
                                    "body": Style(
                                      fontSize: FontSize(18),
                                    ),
                                    "h1": Style(fontSize: FontSize(20)),
                                    "p": Style(fontSize: FontSize(17)),
                                    "li": Style(fontSize: FontSize(15)),
                                    "ul": Style(margin: Margins.all(10)),
                                  },
                                ),

                                // Text(
                                //   parseHtmlString(
                                //       blogDetails.value?.content ?? ''),
                                //   style: TextStyle(
                                //     fontSize: 15.5,
                                //     color: Colors.grey.shade800,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Reading progress bar
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: LinearProgressIndicator(
                      value: _scrollProgress,
                      minHeight: 3,
                      backgroundColor: Colors.transparent,
                      color: AppColor.color77DC,
                    ),
                  ),

                  // Bottom action bar
                  // Positioned(
                  //   bottom: 0,
                  //   left: 0,
                  //   right: 0,
                  //   child: Container(
                  //     padding: EdgeInsets.fromLTRB(
                  //         20, 14, 20, MediaQuery.of(context).padding.bottom + 14),
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black.withOpacity(0.08),
                  //           blurRadius: 20,
                  //           offset: const Offset(0, -4),
                  //         ),
                  //       ],
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         // Like button
                  //         GestureDetector(
                  //           onTap: () => setState(() {
                  //             _isLiked = !_isLiked;
                  //             _likeCount += _isLiked ? 1 : -1;
                  //           }),
                  //           child: AnimatedContainer(
                  //             duration: const Duration(milliseconds: 250),
                  //             curve: Curves.easeOutBack,
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 16, vertical: 10),
                  //             decoration: BoxDecoration(
                  //               color: _isLiked
                  //                   ? const Color(0xFFFF6B6B).withOpacity(0.12)
                  //                   : Colors.grey.shade100,
                  //               borderRadius: BorderRadius.circular(12),
                  //             ),
                  //             child: Row(
                  //               children: [
                  //                 Icon(
                  //                   _isLiked
                  //                       ? Icons.favorite_rounded
                  //                       : Icons.favorite_border_rounded,
                  //                   color: _isLiked
                  //                       ? const Color(0xFFFF6B6B)
                  //                       : Colors.grey.shade500,
                  //                   size: 20,
                  //                 ),
                  //                 const SizedBox(width: 6),
                  //                 Text(
                  //                   '$_likeCount',
                  //                   style: TextStyle(
                  //                     fontWeight: FontWeight.w700,
                  //                     fontSize: 14,
                  //                     color: _isLiked
                  //                         ? const Color(0xFFFF6B6B)
                  //                         : Colors.grey.shade600,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //         const SizedBox(width: 10),

                  //         // Comment button
                  //         Container(
                  //           padding: const EdgeInsets.symmetric(
                  //               horizontal: 16, vertical: 10),
                  //           decoration: BoxDecoration(
                  //             color: Colors.grey.shade100,
                  //             borderRadius: BorderRadius.circular(12),
                  //           ),
                  //           child: Row(
                  //             children: [
                  //               Icon(Icons.chat_bubble_outline_rounded,
                  //                   color: Colors.grey.shade500, size: 20),
                  //               const SizedBox(width: 6),
                  //               Text(
                  //                 '8',
                  //                 style: TextStyle(
                  //                   fontWeight: FontWeight.w700,
                  //                   fontSize: 14,
                  //                   color: Colors.grey.shade600,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),

                  //         const Spacer(),

                  //         // Read Full Article button
                  //         Container(
                  //           padding: const EdgeInsets.symmetric(
                  //               horizontal: 20, vertical: 12),
                  //           decoration: BoxDecoration(
                  //             gradient: const LinearGradient(
                  //               colors: [AppColor.color77DC, Color(0xFF6A8BFF)],
                  //             ),
                  //             borderRadius: BorderRadius.circular(14),
                  //             boxShadow: [
                  //               BoxShadow(
                  //                 color: AppColor.color77DC.withOpacity(0.35),
                  //                 blurRadius: 12,
                  //                 offset: const Offset(0, 4),
                  //               ),
                  //             ],
                  //           ),
                  //           child: const Text(
                  //             'Share Article',
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.w700,
                  //               fontSize: 14,
                  //               letterSpacing: 0.2,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
      ),
    );
  }
}

// class _StatItem extends StatelessWidget {
//   final IconData icon;
//   final String label;

//   const _StatItem({required this.icon, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, size: 16, color: Colors.grey.shade400),
//         const SizedBox(width: 5),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 13,
//             color: Colors.grey.shade500,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _TagChip extends StatelessWidget {
//   final String label;
//   const _TagChip({required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
//       decoration: BoxDecoration(
//         color: const Color(0xFFE8EDFF),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         label,
//         style: const TextStyle(
//           fontSize: 13,
//           fontWeight: FontWeight.w600,
//           color: AppColor.color77DC,
//         ),
//       ),
//     );
//   }
// }
