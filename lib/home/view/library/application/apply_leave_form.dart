import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zob/home/view/library/application/apply_leave_Screen.dart';
import 'package:zob/home/view/notification/notification_screen.dart';
import 'package:zob/models/apply_leave_list_api_response_model.dart';
import 'package:zob/services/api_services.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_style.dart';

// ─── Main Screen ──────────────────────────────────────────────────────────────

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  RxList<LeaveApplication> _allLeaves = <LeaveApplication>[].obs;
  RxList<LeaveApplication> _filteredLeaves = <LeaveApplication>[].obs;
  String _selectedFilter = 'All';
  int _selectedNavIndex = 1;
  RxBool isLoading = false.obs;

  final List<String> _filters = ['All', 'Pending', 'Approved', 'Rejected'];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    isLoading.value = true;
    await Api.applyLeaveListApi().then((value) {
      if (value != null) {
        LeaveListApiResponseModel responseModel =
            LeaveListApiResponseModel.fromJson(value);
        if (responseModel.success == true) {
          _allLeaves.value = responseModel.data ?? [];
          _filteredLeaves.value = responseModel.data ?? [];
          isLoading.value = false;
        } else {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
      }
    }).catchError((error) {
      Get.snackbar("Error", "An error occurred: $error");
    });
  }

  void _applyFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
      if (filter == 'All') {
        _filteredLeaves.value = _allLeaves;
      } else {
        _filteredLeaves.value =
            _allLeaves.where((l) => l.statusText == filter).toList();
      }
    });
  }

  int get _pendingCount =>
      _allLeaves.where((l) => l.statusText == 'Pending').length;
  int get _approvedCount =>
      _allLeaves.where((l) => l.statusText == 'Approved').length;
  int get _rejectedCount =>
      _allLeaves.where((l) => l.statusText == 'Rejected').length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Obx(
        () => isLoading.value
            ? const Center(child: CircularProgressIndicator(
                color: AppColor.color95ED,
            ))
            : Column(
                children: [
                  _buildHeader(),
                  _buildFilterChips(),
                  Expanded(
                    child: _filteredLeaves.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                            itemCount: _filteredLeaves.length,
                            itemBuilder: (context, index) =>
                                LeaveCard(leave: _filteredLeaves[index]),
                          ),
                  ),
                ],
              ),
      ),
      floatingActionButton: _buildApplyButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _divider() => Container(
      height: 30, width: 1, color: AppColor.colorB3FF.withOpacity(0.3));

  // ── Header ──────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      color: AppColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            backgroundColor: AppColor.white,
            elevation: 0,
            title: Row(
              children: [
                Text(
                  'My Leaves',
                  style: AppStyle()
                      .workSansSemiBold(context)
                      .copyWith(fontSize: 20, color: AppColor.color4551),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColor.color77DC.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SummaryTile(
                    label: 'Total',
                    count: _allLeaves.length,
                    color: AppColor.color77DC),
                _divider(),
                SummaryTile(
                    label: 'Pending',
                    count: _pendingCount,
                    color: Colors.amber),
                _divider(),
                SummaryTile(
                    label: 'Approved',
                    count: _approvedCount,
                    color: const Color(0xFF6EE7B7)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color valueColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColor.color77DC.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Filter Chips ─────────────────────────────────────────────────────────────

  Widget _buildFilterChips() {
    return Container(
      color: const Color(0xFFF5F6FA),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _filters.map((filter) {
            final isSelected = _selectedFilter == filter;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => _applyFilter(filter),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColor.color95ED : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? AppColor.color95ED
                          : const Color(0xFFE5E7EB),
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    filter,
                    style: TextStyle(
                      color:
                          isSelected ? Colors.white : const Color(0xFF6B7280),
                      fontSize: 12,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ── Empty State ──────────────────────────────────────────────────────────────

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.event_busy_rounded, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 12),
          Text(
            'No $_selectedFilter leaves found',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // ── Apply Button ─────────────────────────────────────────────────────────────

  Widget _buildApplyButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton.icon(
        onPressed: () async {
          var result = await Get.to(const ApplyForLeaveScreen());
          if (result == true) {
            _loadData();
          }
        },
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text(
          'Apply for Leave',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.color95ED,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 4,
          shadowColor: const Color(0xFF4F46E5).withOpacity(0.4),
        ),
      ),
    );
  }

  // ── Bottom Nav ───────────────────────────────────────────────────────────────

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _selectedNavIndex,
      onTap: (i) => setState(() => _selectedNavIndex = i),
      selectedItemColor: const Color(0xFF4F46E5),
      unselectedItemColor: const Color(0xFF9CA3AF),
      backgroundColor: Colors.white,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle:
          const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event_note_outlined),
          activeIcon: Icon(Icons.event_note_rounded),
          label: 'Leaves',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          activeIcon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ],
    );
  }
}

// ─── Leave Card Widget ────────────────────────────────────────────────────────

class LeaveCard extends StatelessWidget {
  final LeaveApplication leave;

  const LeaveCard({super.key, required this.leave});

  Color get _accentColor {
    switch (leave.statusColor) {
      case 'success':
        return const Color(0xFF10B981);
      case 'warning':
        return const Color(0xFFF59E0B);
      case 'danger':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF9CA3AF);
    }
  }

  Color get _badgeBg {
    switch (leave.statusColor) {
      case 'success':
        return const Color(0xFFD1FAE5);
      case 'warning':
        return const Color(0xFFFEF3C7);
      case 'danger':
        return const Color(0xFFFEE2E2);
      default:
        return const Color(0xFFF3F4F6);
    }
  }

  Color get _badgeText {
    switch (leave.statusColor) {
      case 'success':
        return const Color(0xFF065F46);
      case 'warning':
        return const Color(0xFFB45309);
      case 'danger':
        return const Color(0xFF991B1B);
      default:
        return const Color(0xFF374151);
    }
  }

  Color get _iconBg {
    switch (leave.leaveType) {
      case 'sick-leave':
        return const Color(0xFFD1FAE5);
      case 'paid-leave':
        return const Color(0xFFFEF3C7);
      case 'casual-leave':
        return const Color(0xFFE0E7FF);
      default:
        return const Color(0xFFF3F4F6);
    }
  }

  Color get _iconColor {
    switch (leave.leaveType) {
      case 'sick-leave':
        return const Color(0xFF059669);
      case 'paid-leave':
        return const Color(0xFFD97706);
      case 'casual-leave':
        return const Color(0xFF4F46E5);
      default:
        return const Color(0xFF6B7280);
    }
  }

  IconData get _leaveIcon {
    switch (leave.leaveType) {
      case 'sick-leave':
        return Icons.monitor_heart_outlined;
      case 'paid-leave':
        return Icons.event_available_outlined;
      case 'casual-leave':
        return Icons.beach_access_outlined;
      default:
        return Icons.event_note_outlined;
    }
  }

  String _formatDate(String dateStr) {
    final date = DateTime.tryParse(dateStr);
    if (date == null) return dateStr;
    return DateFormat('MMM dd, yyyy').format(date);
  }

  String _formatAppliedDate(String dateStr) {
    final date = DateTime.tryParse(dateStr);
    if (date == null) return dateStr;
    return DateFormat('MMM dd, yyyy').format(date);
  }

  String formatNumber(dynamic value) {
    final number = double.tryParse(value.toString()) ?? 0;
    return number % 1 == 0 ? number.toInt().toString() : number.toString();
  }

  String get _durationLabel {
    return leave.duration == 'full_day' ? 'Full Day' : 'Half Day';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 0.5),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Colored top accent bar
          Container(height: 4, color: _accentColor),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row 1 – Icon + name + badge
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: _iconBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(_leaveIcon, color: _iconColor, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            leave.leaveTypeName ?? '',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF111827),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _durationLabel,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: _badgeBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        leave.statusText ?? '',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _badgeText,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFF3F4F6)),
                const SizedBox(height: 12),

                // Row 2 – Date range + Days count
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Duration',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${_formatDate(leave.fromDate.toString())} – ${_formatDate(leave.toDate.toString())}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF374151),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Days',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                        Text(
                          formatNumber(leave.days),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: AppColor.color95ED,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Reason box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Reason',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        leave.reason ?? '',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Applied date
                Text(
                  'Applied on ${_formatAppliedDate(leave.createdAt.toString())}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFFD1D5DB),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
