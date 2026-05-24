import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zob/models/notification_model.dart';
import 'package:zob/services/api_services.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_images.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';
import 'package:html/parser.dart';

// class NotificationScreen extends StatelessWidget {
//   const NotificationScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.sizeOf(context).height;
//     double width = MediaQuery.sizeOf(context).width;
//     return Scaffold(
//       backgroundColor: AppColor.white,
//       appBar: AppBar(
//         title: const Text("Notification"),
//         titleTextStyle: AppStyle()
//             .workSansSemiBold(context)
//             .copyWith(fontSize: 20, color: AppColor.color4551),
//         leading: InkWell(
//           onTap: () {
//             Get.back();
//           },
//           child: Center(
//             child: SvgPicture.asset(
//               AppImg.crossIcon,
//               height: 18,
//               width: 18,
//             ),
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(4.0),
//           child: Container(
//             color: AppColor.colorB5BA,
//             height: 1.0,
//           ),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             AppHelper().verticalSpace(size: height * 0.2),
//             SvgPicture.asset(AppImg.alertIcon),
//             AppHelper().verticalSpace(size: 30),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 50),
//               child: Text(
//                 "You don't have notification yet, \nnotifications give you certain information",
//                 textAlign: TextAlign.center,
//                 style: AppStyle().workSansMedium(context).copyWith(
//                       color: AppColor.color8686,
//                     ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ─────────────────────────────────────────
//  SCREEN
// ─────────────────────────────────────────
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'All';

  RxBool isLoading = false.obs;
  RxList<NotificationModel> _notifications = <NotificationModel>[].obs;

  ///// Get Notification list api
  _fetchNotificationList() {
    isLoading.value = true;
    return Api.getNotificatinListApi().then((response) {
      log("Check My Job Details api response : 1 $response");
      if (response != null) {
        NotificationResponseModel responseModel =
            NotificationResponseModel.fromJson(response);
        if (responseModel.success == true) {
          _notifications.value = responseModel.data ?? [];
          isLoading.value = false;
        } else {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
      }
    });
  }

  //// View Notification api
  _viewNotification({required String notificationId}) {
    return Api.viewNotificationApi(notificationId: notificationId)
        .then((response) {
      log("Check view notification api response : $response");
      if (response != null) {
        if (response['success'] == true) {
          _fetchNotificationList();
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchNotificationList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<NotificationModel> get _filtered {
    switch (_selectedFilter) {
      case 'Seen':
        return _notifications.where((n) => n.statusText == 'Seen').toList();
      case 'Unseen':
        return _notifications.where((n) => n.statusText == 'Unseen').toList();
      default:
        return _notifications;
    }
  }

  int get _unseenCount =>
      _notifications.where((n) => n.statusText == 'Unseen').length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: _buildAppBar(),
      body: Obx(
        () => isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                color: AppColor.color77DC,
              ))
            : Column(
                children: [
                  _buildFilterChips(),
                  Divider(
                    height: 0,
                    color: AppColor.color77DC.withOpacity(0.2),
                  ),
                  _buildSummaryBanner(),
                  Expanded(
                    child: _filtered.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                            itemCount: _filtered.length,
                            itemBuilder: (ctx, i) {
                              final n = _filtered[i];
                              log('lkklkNotification ${n.id} - ${n.title} - Status: ${n.statusText} ///// ${n.priority}');
                              return _NotificationCard(
                                  notification: n,
                                  onTap: () {
                                    log('Tapped notification ${n.id} - ${n.title} - Status: ${n.statusText} ///// ${n.priority}');
                                    if (n.statusText == 'Unseen') {
                                      _viewNotification(
                                          notificationId: n.id.toString());
                                    }
                                  });
                            }),
                  ),
                ],
              ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.white,
      elevation: 0,
      title: Row(
        children: [
          const Text(
            'Notifications',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['All', 'Unseen', 'Seen'];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      child: Row(
        children: filters.map((f) {
          final isSelected = _selectedFilter == f;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedFilter = f),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColor.color77DC
                      : AppColor.color77DC.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  f,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColor.color77DC,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSummaryBanner() {
    final total = _notifications.length;
    final seen = _notifications.where((n) => n.statusText == 'Seen').length;
    final unseen = _notifications.where((n) => n.statusText == 'Unseen').length;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SummaryTile(label: 'Total', count: total, color: AppColor.color77DC),
          _divider(),
          SummaryTile(
              label: 'Seen', count: seen, color: const Color(0xFF10B981)),
          _divider(),
          SummaryTile(
              label: 'Unseen', count: unseen, color: const Color(0xFFEF4444)),
        ],
      ),
    );
  }

  Widget _divider() => Container(
      height: 30, width: 1, color: AppColor.colorB3FF.withOpacity(0.3));

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.notifications_off_outlined,
              size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 12),
          Text(
            'No notifications found',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _onNotificationTap(NotificationModel n) {
    // showModalBottomSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    //   ),
    //   builder: (_) => _NotificationDetailSheet(notification: n),
    // );
  }
}

// ─────────────────────────────────────────
//  NOTIFICATION CARD
// ─────────────────────────────────────────
class _NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const _NotificationCard({required this.notification, required this.onTap});

  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    return document.body?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final n = notification;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: n.statusText == 'Seen'
                ? Colors.transparent
                : AppColor.color77DC.withOpacity(0.25),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon avatar
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: _priorityColor(n.priority ?? '').withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _priorityIcon(n.priority ?? ''),
                  color: _priorityColor(n.priority ?? ''),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            n.title ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: n.statusText == 'Seen'
                                  ? FontWeight.w500
                                  : FontWeight.w700,
                              color: const Color(0xFF1E1E2E),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        // Seen/Unseen badge
                        _StatusBadge(
                            isSeen: n.statusText == 'Seen',
                            label: n.statusText ?? ''),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      parseHtmlString(n.description ?? ''),
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _PriorityChip(priority: n.priority ?? ''),
                        const Spacer(),
                        Icon(Icons.access_time,
                            size: 12, color: Colors.grey.shade400),
                        const SizedBox(width: 3),
                        Text(
                          _timeAgo(n.createdAt!),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _priorityColor(String priority) {
    switch (priority) {
      case 'high':
        return const Color(0xFFEF4444);
      case 'medium':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF10B981);
    }
  }

  IconData _priorityIcon(String priority) {
    switch (priority) {
      case 'high':
        return Icons.priority_high_rounded;
      case 'medium':
        return Icons.notifications_rounded;
      default:
        return Icons.info_outline_rounded;
    }
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'Just now';
  }
}

// ─────────────────────────────────────────
//  WIDGETS
// ─────────────────────────────────────────
class _StatusBadge extends StatelessWidget {
  final bool isSeen;
  final String label;

  const _StatusBadge({required this.isSeen, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isSeen
            ? const Color(0xFF10B981).withOpacity(0.1)
            : const Color(0xFFEF4444).withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: isSeen ? const Color(0xFF10B981) : const Color(0xFFEF4444),
        ),
      ),
    );
  }
}

class _PriorityChip extends StatelessWidget {
  final String priority;

  const _PriorityChip({required this.priority});

  @override
  Widget build(BuildContext context) {
    Color color;
    log('Notification priority: $priority');
    switch (priority) {
      case 'low':
        color = const Color(0xFF10B981);
        break;
      case 'medium':
        color = const Color(0xFFF59E0B);
        break;
      default:
        color = const Color(0xFFEF4444);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(
            priority[0].toUpperCase() + priority.substring(1),
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryTile extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const SummaryTile(
      {required this.label, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$count',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
