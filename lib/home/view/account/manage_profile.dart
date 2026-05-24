// import 'dart:developer';

// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/get_rx.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:zob/local_store/shar_pref.dart';
// import 'package:zob/models/update_profile_response_model.dart';
// import 'package:zob/models/user_profile_response_model.dart';
// import 'package:zob/services/api_services.dart';
// import 'package:zob/utils/app_color.dart';
// import 'package:zob/utils/app_style.dart';
// import 'package:zob/utils/common_snackbar.dart';
// import 'package:zob/widget/snack_bar_widget.dart';

// // ─── Screen ──────────────────────────────────────────────────────────────────

// class ManageProfileScreen extends StatefulWidget {
//   const ManageProfileScreen({super.key});

//   @override
//   State<ManageProfileScreen> createState() => _ManageProfileScreenState();
// }

// class _ManageProfileScreenState extends State<ManageProfileScreen> {
//   static const _primaryBlue = AppColor.color77DC;
//   static const _lightBlue = AppColor.lightBlue;
//   static const _lightTeal = AppColor.lightBlue;
//   static const _lightAmber = Color(0xFFFAEEDA);
//   // static const _lightCoral = Color(0xFFFAECE7);
//   // static const _dangerRed = Color(0xFFE24B4A);
//   // static const _dangerRedLight = Color(0xFFF09595);

//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _firstNameCtrl = TextEditingController();
//   final TextEditingController _lastNameCtrl = TextEditingController();
//   // late final TextEditingController _passwordCtrl;
//   // late final TextEditingController _confirmPasswordCtrl;

//   DateTime _selectedDob = DateTime(2000, 8, 5);
//   // bool _obscurePassword = true;
//   // bool _obscureConfirm = true;
//   // bool _isSaving = false;
//   RxString phoneNumber = ''.obs;
//   RxString countryCode = ''.obs;

//   // Pre-filled user data
//   RxBool isUpdateProfileLoading = false.obs;
//   RxBool fetchUSerProfile = false.obs;

//   /// Update User Profile
//   updateProfileApiCall() {
//     Map<String, dynamic> param = {
//       "first_name": _firstNameCtrl.text.trim(),
//       "last_name": _lastNameCtrl.text.trim(),
//       "dob":
//           "${_selectedDob.year.toString().padLeft(4, '0')}-${_selectedDob.month.toString().padLeft(2, '0')}-${_selectedDob.day.toString().padLeft(2, '0')}",
//       "country_id": countryCode.value,
//       // "password": "123456",
//       // "password_confirmation": "123456"
//     };
//     log("Update Profile Request: $param");

//     isUpdateProfileLoading.value = true;

//     return Api.updateProfileApi(param).then((response) {
//       isUpdateProfileLoading.value = false;
//       log("Update Profile Response: $response");
//       if (response != null) {
//         UpdateProfileResponseModel updateResponse =
//             UpdateProfileResponseModel.fromJson(response);
//         if (updateResponse.success == true) {
//           fetchUserProfile();
//             CommonSnackBarWidget().snackBarWidget(
//             context: Get.context!,
//             title: "Well done!",
//             message: updateResponse.message ?? '',
//             snackBarType: ContentType.success,
//           );
//           // Get.to(BottomNavigationScreen());
//         } else {
//             CommonSnackBarWidget().snackBarWidget(
//             context: Get.context!,
//             title: "Oh Snap!",
//             message: updateResponse.message ?? '',
//             snackBarType: ContentType.failure,
//           );
//         }
//       }
//     });
//   }

//   //// Fetch User Profile
//   fetchUserProfile() {
//     fetchUSerProfile.value = true;
//     Api.getLoginUSerDetailsApis().then((response) {
//       fetchUSerProfile.value = false;
//       if (response != null) {
//         UserProfileResponseModel userProfileResponseModel =
//             UserProfileResponseModel.fromJson(response);
//         if (userProfileResponseModel.id != null) {
//           _firstNameCtrl.text = userProfileResponseModel.firstName ?? '';
//           _lastNameCtrl.text = userProfileResponseModel.lastName ?? '';
//           _selectedDob =
//               DateTime.tryParse(userProfileResponseModel.dob ?? '') ??
//                   DateTime.now();
//           phoneNumber.value = userProfileResponseModel.phone ?? '';
//           countryCode.value = userProfileResponseModel.countryId ?? '';
//           SharePref().setUserName(
//               setUserName: userProfileResponseModel.firstName ?? "");
//           SharePref()
//               .setUserEmail(setUserEmail: userProfileResponseModel.email ?? "");
//           SharePref()
//               .setUserDOB(setUserDOB: userProfileResponseModel.dob ?? "");
//           SharePref().setUserMobile(
//               setUserMobile: userProfileResponseModel.phone ?? "");
//         }
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchUserProfile();
//   }

//   @override
//   void dispose() {
//     _firstNameCtrl.dispose();
//     _lastNameCtrl.dispose();
//     // _passwordCtrl.dispose();
//     // _confirmPasswordCtrl.dispose();
//     super.dispose();
//   }

//   // ── Helpers ────────────────────────────────────────────────────────────────

//   // String get _initials {
//   //   final f = _firstNameCtrl.text.trim();
//   //   final l = _lastNameCtrl.text.trim();
//   //   return '${f.isNotEmpty ? f[0].toUpperCase() : ''}${l.isNotEmpty ? l[0].toUpperCase() : ''}';
//   // }

//   // String get _fullName {
//   //   final name =
//   //       '${_firstNameCtrl.text.trim()} ${_lastNameCtrl.text.trim()}'.trim();
//   //   return name.isEmpty ? 'Your Name' : name;
//   // }

//   String get _formattedDob {
//     const months = [
//       '',
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec'
//     ];
//     return '${_selectedDob.day.toString().padLeft(2, '0')} '
//         '${months[_selectedDob.month]} ${_selectedDob.year}';
//   }

//   Future<void> _pickDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDob,
//       firstDate: DateTime(1950),
//       lastDate: DateTime.now(),
//       builder: (context, child) => Theme(
//         data: Theme.of(context).copyWith(
//           colorScheme: const ColorScheme.light(primary: _primaryBlue),
//         ),
//         child: child!,
//       ),
//     );
//     if (picked != null) setState(() => _selectedDob = picked);
//   }

//   Widget _sectionLabel(String text) => Padding(
//         padding: const EdgeInsets.only(bottom: 10),
//         child: Text(
//           text.toUpperCase(),
//           style: const TextStyle(
//             fontSize: 11,
//             fontWeight: FontWeight.w700,
//             color: _primaryBlue,
//             letterSpacing: 0.7,
//           ),
//         ),
//       );

//   Widget _buildCardSection(List<Widget> children) => Container(
//         decoration: BoxDecoration(
//           color: Colors.grey.shade50,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: Colors.grey.shade200, width: 0.5),
//         ),
//         child: Column(
//           children: children.map((child) => child).expand((child) sync* {
//             yield child;
//             if (child != children.last) {
//               yield const Divider(height: 0.5, thickness: 0.5, indent: 56);
//             }
//           }).toList(),
//         ),
//       );

//   Widget _buildFieldRow({
//     required IconData icon,
//     required Color iconBg,
//     required Color iconColor,
//     required Widget field,
//     bool showArrow = true,
//   }) =>
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//         child: Row(
//           children: [
//             Container(
//               width: 32,
//               height: 32,
//               decoration: BoxDecoration(
//                 color: iconBg,
//                 borderRadius: BorderRadius.circular(9),
//               ),
//               child: Icon(icon, size: 16, color: iconColor),
//             ),
//             const SizedBox(width: 12),
//             Expanded(child: field),
//             if (showArrow)
//               const Icon(Icons.chevron_right_rounded,
//                   size: 18, color: Colors.black38),
//           ],
//         ),
//       );

//   Widget _buildLabeledInput({
//     required String label,
//     required TextEditingController controller,
//     bool obscure = false,
//     bool isPassword = false,
//     bool isConfirm = false,
//     String? Function(String?)? validator,
//     VoidCallback? onToggleObscure,
//   }) =>
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label,
//               style: const TextStyle(
//                   fontSize: 11,
//                   color: Colors.black45,
//                   fontWeight: FontWeight.w600)),
//           const SizedBox(height: 2),
//           TextFormField(
//             controller: controller,
//             obscureText: obscure,
//             validator: validator,
//             style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87),
//             decoration: InputDecoration(
//               isDense: true,
//               contentPadding: EdgeInsets.zero,
//               border: InputBorder.none,
//               suffixIcon: onToggleObscure != null
//                   ? GestureDetector(
//                       onTap: onToggleObscure,
//                       child: Icon(
//                         obscure
//                             ? Icons.visibility_off_outlined
//                             : Icons.visibility_outlined,
//                         size: 16,
//                         color: Colors.black38,
//                       ),
//                     )
//                   : null,
//             ),
//           ),
//         ],
//       );

//   // ── Build ──────────────────────────────────────────────────────────────────

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.white,
//       appBar: AppBar(
//           backgroundColor: AppColor.white,
//           leading: IconButton(
//             onPressed: () => Get.back(),
//             icon: const Icon(Icons.arrow_back_rounded,
//                 size: 25, color: AppColor.color4551),
//           ),
//           title: Text(
//             "Manage Profile",
//             style: AppStyle()
//                 .workSansSemiBold(context)
//                 .copyWith(fontSize: 20, color: AppColor.color4551),
//           ),
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(0),
//             child: Container(
//               color: AppColor.color969D,
//               height: 1.0,
//             ),
//           )),
//       body: Obx(
//         () => fetchUSerProfile.value
//             ? Center(
//                 child: CircularProgressIndicator(
//                 color: AppColor.color8EE9,
//               ))
//             : SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     // ── Top Bar ──

//                     // ── Scrollable Body ──
//                     SingleChildScrollView(
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(18),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // Personal Info
//                                   _sectionLabel('Personal Info'),
//                                   _buildCardSection([
//                                     _buildFieldRow(
//                                       icon: Icons.person_outline_rounded,
//                                       iconBg: _lightBlue,
//                                       iconColor: _primaryBlue,
//                                       field: _buildLabeledInput(
//                                         label: 'First Name',
//                                         controller: _firstNameCtrl,
//                                         validator: (v) =>
//                                             v == null || v.trim().isEmpty
//                                                 ? 'Required'
//                                                 : null,
//                                       ),
//                                     ),
//                                     _buildFieldRow(
//                                       icon: Icons.person_outline_rounded,
//                                       iconBg: _lightBlue,
//                                       iconColor: _primaryBlue,
//                                       field: _buildLabeledInput(
//                                         label: 'Last Name',
//                                         controller: _lastNameCtrl,
//                                         validator: (v) =>
//                                             v == null || v.trim().isEmpty
//                                                 ? 'Required'
//                                                 : null,
//                                       ),
//                                     ),
//                                     _buildFieldRow(
//                                       icon: Icons.calendar_month_outlined,
//                                       iconBg: _lightAmber,
//                                       iconColor: const Color(0xFFBA7517),
//                                       showArrow: false,
//                                       field: GestureDetector(
//                                         onTap: _pickDate,
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             const Text('Date of Birth',
//                                                 style: TextStyle(
//                                                     fontSize: 11,
//                                                     color: Colors.black45,
//                                                     fontWeight:
//                                                         FontWeight.w600)),
//                                             const SizedBox(height: 2),
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   _formattedDob,
//                                                   style: const TextStyle(
//                                                       fontSize: 14,
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       color: Colors.black87),
//                                                 ),
//                                                 const Spacer(),
//                                                 const Icon(
//                                                     Icons.chevron_right_rounded,
//                                                     size: 18,
//                                                     color: Colors.black38),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ]),

//                                   const SizedBox(height: 20),

//                                   // Contact & Region
//                                   _sectionLabel('Contact & Region'),
//                                   _buildCardSection([
//                                     _buildFieldRow(
//                                       icon: Icons.language_rounded,
//                                       iconBg: _lightTeal,
//                                       iconColor: const Color(0xFF0F6E56),
//                                       showArrow: true,
//                                       field: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text('Country Code',
//                                               style: TextStyle(
//                                                   fontSize: 11,
//                                                   color: Colors.black45,
//                                                   fontWeight: FontWeight.w600)),
//                                           SizedBox(height: 2),
//                                           Obx(
//                                             () => Text(
//                                                 '+91 ${phoneNumber.value}',
//                                                 style: TextStyle(
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.w600,
//                                                     color: Colors.black54)),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ]),

//                                   const SizedBox(height: 20),

//                                   // Security
//                                   // _sectionLabel('Security'),
//                                   // _buildCardSection([
//                                   //   _buildFieldRow(
//                                   //     icon: Icons.lock_outline_rounded,
//                                   //     iconBg: _lightCoral,
//                                   //     iconColor: const Color(0xFF993C1D),
//                                   //     field: _buildLabeledInput(
//                                   //       label: 'Password',
//                                   //       controller: _passwordCtrl,
//                                   //       obscure: _obscurePassword,
//                                   //       isPassword: true,
//                                   //       validator: (v) {
//                                   //         if (v == null || v.isEmpty) return 'Required';
//                                   //         if (v.length < 6) return 'Min 6 characters';
//                                   //         return null;
//                                   //       },
//                                   //       onToggleObscure: () => setState(
//                                   //           () => _obscurePassword = !_obscurePassword),
//                                   //     ),
//                                   //   ),
//                                   //   _buildFieldRow(
//                                   //     icon: Icons.check_circle_outline_rounded,
//                                   //     iconBg: _lightCoral,
//                                   //     iconColor: const Color(0xFF993C1D),
//                                   //     field: _buildLabeledInput(
//                                   //       label: 'Confirm Password',
//                                   //       controller: _confirmPasswordCtrl,
//                                   //       obscure: _obscureConfirm,
//                                   //       isConfirm: true,
//                                   //       validator: (v) {
//                                   //         if (v != _passwordCtrl.text) {
//                                   //           return 'Passwords do not match';
//                                   //         }
//                                   //         return null;
//                                   //       },
//                                   //       onToggleObscure: () => setState(
//                                   //           () => _obscureConfirm = !_obscureConfirm),
//                                   //     ),
//                                   //   ),
//                                   // ]),

//                                   const SizedBox(height: 24),

//                                   // Update Button
//                                   Obx(
//                                     () => SizedBox(
//                                       width: double.infinity,
//                                       child: ElevatedButton(
//                                         onPressed: () {
//                                           if (!_formKey.currentState!
//                                               .validate()) return;

//                                           updateProfileApiCall();
//                                         },
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor: AppColor.color8EE9,
//                                           foregroundColor: Colors.white,
//                                           disabledBackgroundColor:
//                                               _primaryBlue.withOpacity(0.6),
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 15),
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(14)),
//                                           elevation: 0,
//                                         ),
//                                         child: isUpdateProfileLoading.value
//                                             ? const SizedBox(
//                                                 width: 20,
//                                                 height: 20,
//                                                 child:
//                                                     CircularProgressIndicator(
//                                                         color: Colors.white,
//                                                         strokeWidth: 2),
//                                               )
//                                             : const Text(
//                                                 'Update Profile',
//                                                 style: TextStyle(
//                                                     fontSize: 15,
//                                                     fontWeight:
//                                                         FontWeight.w700),
//                                               ),
//                                       ),
//                                     ),
//                                   ),

//                                   // const SizedBox(height: 10),

//                                   // // Delete Account
//                                   // SizedBox(
//                                   //   width: double.infinity,
//                                   //   child: OutlinedButton(
//                                   //     onPressed: _handleDeleteAccount,
//                                   //     style: OutlinedButton.styleFrom(
//                                   //       foregroundColor: _dangerRed,
//                                   //       side: const BorderSide(
//                                   //           color: _dangerRedLight, width: 1.5),
//                                   //       padding:
//                                   //           const EdgeInsets.symmetric(vertical: 13),
//                                   //       shape: RoundedRectangleBorder(
//                                   //           borderRadius: BorderRadius.circular(14)),
//                                   //     ),
//                                   //     child: const Text(
//                                   //       'Delete Account',
//                                   //       style: TextStyle(
//                                   //           fontSize: 14, fontWeight: FontWeight.w700),
//                                   //     ),
//                                   //   ),
//                                   // ),

//                                   const SizedBox(height: 12),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_style.dart';

// ─── THEME COLORS ─────────────────────────────────────────────────────────────
class AppColors {
  static const navy = Color(0xFF0B1628);
  static const navyMid = Color(0xFF14243F);
  static const navyLight = Color(0xFF1E3458);
  static const accent = AppColor.color95ED;
  static const accentDim = AppColor.color77DC;
  static Color accentBg = AppColor.colorB3FF.withOpacity(0.5);
  static const gold = Color(0xFFF5A623);
  static const goldBg = Color(0xFFFEF3D7);
  static const goldText = Color(0xFF8A5E0A);
  static const success = Color(0xFF3B9E62);
  static const successBg = Color(0xFFEAF3DE);
  static const danger = Color(0xFFE24B4A);
  static const dangerBg = Color(0xFFFCEBEB);
  static const surface = Color(0xFFF2F5FA);
  static const card = Color(0xFFFFFFFF);
  static const border = Color(0xFFDDE3EF);
  static const textColor = Color(0xFF1A2340);
  static const textSub = Color(0xFF5A6478);
  static const muted = Color(0xFF8892A4);
}

// ─── DATA MODELS ──────────────────────────────────────────────────────────────
class Category {
  final String id, icon, label;
  final List<String> roles;
  const Category(
      {required this.id,
      required this.icon,
      required this.label,
      required this.roles});
}

const List<Category> CATEGORIES = [
  Category(id: 'security', icon: '🛡️', label: 'Security Services', roles: [
    'Security Guard',
    'Crowd Controller',
    'Event Security',
    'Mobile Patrol',
    'Loss Prevention Officer'
  ]),
  Category(
      id: 'healthcare',
      icon: '🧑‍⚕️',
      label: 'Healthcare & Medical',
      roles: [
        'Registered Nurse',
        'Enrolled Nurse',
        'Healthcare Assistant',
        'Medical Receptionist',
        'Pharmacy Assistant'
      ]),
  Category(id: 'care', icon: '❤️', label: 'Care & Support Services', roles: [
    'Support Worker',
    'Community Care Worker',
    'NDIS Support Coordinator',
    'Personal Carer',
    'Disability Support Worker'
  ]),
  Category(id: 'childcare', icon: '👶', label: 'Childcare Services', roles: [
    'Early Childhood Educator',
    'Childcare Assistant',
    'Nanny',
    'OSHC Educator',
    'Family Day Care Educator'
  ]),
  Category(id: 'cleaning', icon: '🧹', label: 'Cleaning & Facilities', roles: [
    'Commercial Cleaner',
    'Domestic Cleaner',
    'Facility Manager',
    'Grounds Maintenance',
    'Waste Management'
  ]),
  Category(id: 'trades', icon: '🏗️', label: 'Trades & Construction', roles: [
    'Carpenter',
    'Electrician',
    'Plumber',
    'Labourer',
    'Site Supervisor',
    'Concreter'
  ]),
  Category(id: 'logistics', icon: '🚚', label: 'Logistics & Warehouse', roles: [
    'Forklift Operator',
    'Truck Driver',
    'Warehouse Picker/Packer',
    'Storeperson',
    'Delivery Driver'
  ]),
  Category(id: 'admin', icon: '🏢', label: 'Office & Admin Support', roles: [
    'Receptionist',
    'Data Entry Operator',
    'Executive Assistant',
    'Office Administrator',
    'HR Coordinator'
  ]),
  Category(
      id: 'hospitality',
      icon: '🍽️',
      label: 'Hospitality & Retail',
      roles: [
        'Chef',
        'Barista',
        'Waiter/Waitress',
        'Retail Sales Assistant',
        'Hotel Front Desk'
      ]),
];

const Map<String, List<String>> CAT_CERTS = {
  'security': [
    'Cert II in Security Operations',
    'Cert III in Security Operations',
    'Security Licence (NSW/VIC/QLD)',
    'Police Check',
    'First Aid Certificate'
  ],
  'healthcare': [
    'Nursing Degree / AHPRA Registration',
    'Pharmacy Registration',
    'First Aid Certificate',
    'Police Check',
    'CPR Certificate'
  ],
  'care': [
    'Cert III in Individual Support',
    'NDIS Worker Screening Check',
    'First Aid & CPR',
    'Police Check',
    'Manual Handling Certificate'
  ],
  'childcare': [
    'Cert III in Early Childhood Education',
    'Working With Children Check (WWCC)',
    'First Aid Certificate',
    'CPR Certificate',
    'Police Check'
  ],
  'cleaning': [
    'General Induction',
    'Chemical Handling Certificate',
    'White Card (if site work)',
    'Police Check'
  ],
  'trades': [
    'White Card (MANDATORY)',
    'Trade Certificate / Apprenticeship',
    'Police Check',
    'Asbestos Awareness',
    'Working at Heights'
  ],
  'logistics': [
    'Forklift Licence (LF)',
    'Heavy Rigid (HR) Licence',
    'Police Check',
    'White Card (if site work)',
    'Manual Handling Certificate'
  ],
  'admin': [
    'Cert III in Business Administration',
    'Police Check',
    'Microsoft Office Certifications'
  ],
  'hospitality': [
    'RSA Certificate',
    'Food Safety / Food Handling Certificate',
    'Police Check',
    'Barista Certificate'
  ],
};

const Map<String, List<String>> REQ_CERTS = {
  'security': ['Security Licence (NSW/VIC/QLD)', 'Police Check'],
  'healthcare': ['Nursing Degree / AHPRA Registration', 'Police Check'],
  'care': ['Cert III in Individual Support', 'NDIS Worker Screening Check'],
  'childcare': [
    'Working With Children Check (WWCC)',
    'Cert III in Early Childhood Education'
  ],
  'cleaning': ['General Induction'],
  'trades': ['White Card (MANDATORY)'],
  'logistics': ['Police Check'],
  'admin': ['Police Check'],
  'hospitality': ['RSA Certificate', 'Food Safety / Food Handling Certificate'],
};

const List<String> ALL_STEPS = [
  'Account',
  'Profile Type',
  'Services',
  'Availability',
  'Experience',
  'Education',
  'Certifications',
  'Work Rights',
  'ID Check',
  'Enhancements',
  'Compliance',
  'Agreement'
];

// ─── FORM STATE ───────────────────────────────────────────────────────────────
class FormState extends ChangeNotifier {
  String firstName = '',
      lastName = '',
      mobile = '',
      email = '',
      confirmEmail = '',
      password = '',
      confirmPassword = '';
  String profileType = '';
  String category = '', selectedRole = '';
  List<String> employmentType = [], days = [], timeSlots = [];
  String dateFrom = '', dateTo = '';
  String hasExperience = '';
  List<Map<String, String>> experiences = [
    {
      'employer': '',
      'company': '',
      'contact': '',
      'address': '',
      'title': '',
      'duties': ''
    }
  ];
  String education = '';
  List<String> certs = [];
  String workRights = '';
  List<String> idDocs = [];
  String bio = '', skills = '', languages = '', rate = '', radius = '';
  String policeCheck = '', wwcc = '', ndis = '';
  bool agreeTerms = false, confirmInfo = false;

  void notify() => notifyListeners();

  void toggleList(String field, String val) {
    List<String> list = _getList(field);
    if (list.contains(val))
      list.remove(val);
    else
      list.add(val);
    notifyListeners();
  }

  List<String> _getList(String field) {
    switch (field) {
      case 'employmentType':
        return employmentType;
      case 'days':
        return days;
      case 'timeSlots':
        return timeSlots;
      case 'certs':
        return certs;
      case 'idDocs':
        return idDocs;
      default:
        return [];
    }
  }

  int calcReadiness() {
    if (category.isEmpty) return 0;
    final req = REQ_CERTS[category] ?? [];
    final done = req.where((c) => certs.contains(c)).length;
    int score = 0;
    if (firstName.isNotEmpty) score += 5;
    if (selectedRole.isNotEmpty) score += 5;
    if (employmentType.isNotEmpty) score += 5;
    if (hasExperience == 'Yes')
      score += 10;
    else if (hasExperience == 'No') score += 5;
    if (education.isNotEmpty) score += 5;
    if (req.isNotEmpty) {
      score += ((done / req.length) * 40).round();
    } else {
      score += 20;
    }
    if (workRights.isNotEmpty) score += 5;
    if (idDocs.length >= 2) {
      score += 10;
    } else if (idDocs.length == 1) {
      score += 5;
    }
    if (bio.isNotEmpty) score += 5;
    if (agreeTerms) score += 5;
    return score.clamp(0, 100);
  }
}

// ─── MAIN SCREEN ──────────────────────────────────────────────────────────────
class ManageProfileScreen extends StatefulWidget {
  const ManageProfileScreen({super.key});
  @override
  State<ManageProfileScreen> createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends State<ManageProfileScreen>
    with TickerProviderStateMixin {
  int _step = 1;
  bool _submitted = false;
  final FormState _form = FormState();
  late final String _workerId;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    final rng = Random();
    _workerId = 'BKP-STF-${100000 + rng.nextInt(900000)}';
    _fadeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _slideController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _stepNavScroll.dispose();
    super.dispose();
  }

  void _animateStep() {
    _fadeController.reset();
    _slideController.reset();
    _fadeController.forward();
    _slideController.forward();
  }

  List<String> _getSteps() {
    if (_form.profileType == 'Job Seeker') {
      return ALL_STEPS.where((s) => s != 'Services').toList();
    }
    return ALL_STEPS;
  }

  int _getStepIndex() {
    final steps = _getSteps();
    final name = ALL_STEPS[_step - 1];
    return steps.indexOf(name);
  }

  void _nextStep() {
    if (_step == 12) {
      setState(() => _submitted = true);
      return;
    }
    setState(() {
      if (_form.profileType == 'Job Seeker' && _step == 2) {
        _step = 4;
      } else {
        _step = (_step + 1).clamp(1, 12);
      }
    });
    _animateStep();
  }

  void _prevStep() {
    if (_step == 1) return;
    setState(() {
      if (_form.profileType == 'Job Seeker' && _step == 4) {
        _step = 2;
      } else {
        _step = (_step - 1).clamp(1, 12);
      }
    });
    _animateStep();
  }

  void _goStep(int targetStep) {
    if (targetStep < _step) {
      setState(() {
        _step = targetStep;
      });
      _animateStep();
    }
  }

  // void _saveDraft() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: const Row(
  //         children: [
  //           Text('💾  Draft saved!',
  //               style: TextStyle(fontWeight: FontWeight.w600)),
  //         ],
  //       ),
  //       backgroundColor: AppColors.navy,
  //       behavior: SnackBarBehavior.floating,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //       duration: const Duration(seconds: 2),
  //     ),
  //   );
  // }

  bool _isNextEnabled() {
    if (_step == 12) return _form.agreeTerms && _form.confirmInfo;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (_submitted) return _buildSuccessScreen();
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
          backgroundColor: AppColor.white,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_rounded,
                size: 25, color: AppColor.color4551),
          ),
          title: Text(
            "Manage Profile",
            style: AppStyle()
                .workSansSemiBold(context)
                .copyWith(fontSize: 20, color: AppColor.color4551),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Container(
              color: AppColor.color969D,
              height: 1.0,
            ),
          )),
      body: Column(
        children: [
          // _buildHeader(),
          _buildStepNav(),
          if (_step > 3 && _form.category.isNotEmpty) _buildReadinessBanner(),
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 120),
                  children: [_buildCurrentStep()],
                ),
              ),
            ),
          ),
          _buildNavFooter(),
        ],
      ),
    );
  }

  // ─── HEADER ─────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    final name = _form.firstName.isNotEmpty
        ? '${_form.firstName}${_form.lastName.isNotEmpty ? ' ${_form.lastName}' : ''}'
        : '';
    return Container(
      color: AppColors.navy,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        bottom: 12,
        left: 20,
        right: 20,
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: const Text('B',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    letterSpacing: 0)),
          ),
          const SizedBox(width: 10),
          const Text('BACKUPP',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  letterSpacing: 1.5)),
          const SizedBox(width: 6),
          const Text('Workforce',
              style: TextStyle(color: AppColors.muted, fontSize: 12)),
          const Spacer(),
          if (name.isNotEmpty) ...[
            Text('👤 $name',
                style: const TextStyle(color: AppColors.muted, fontSize: 12)),
            const SizedBox(width: 10),
          ],
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.navyMid,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.navyLight),
            ),
            child: Text(_workerId,
                style: const TextStyle(
                    color: AppColors.accent,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5)),
          ),
        ],
      ),
    );
  }

  // ─── STEP NAV ───────────────────────────────────────────────────────────────
  final ScrollController _stepNavScroll = ScrollController();

  void _scrollNavToActive() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final steps = _getSteps();
      final currentIdx = _getStepIndex();
      if (!_stepNavScroll.hasClients) return;
      // Each item ~110px wide; scroll so active is near center
      final screenW = MediaQuery.of(context).size.width;
      final itemW = 110.0;
      final targetOffset = (currentIdx * itemW) - (screenW / 2) + (itemW / 2);
      _stepNavScroll.animateTo(
        targetOffset.clamp(0.0, _stepNavScroll.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Widget _buildStepNav() {
    final steps = _getSteps();
    final currentIdx = _getStepIndex();
    // Auto scroll to active after build
    _scrollNavToActive();
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      height: 52,
      child: ListView.builder(
        controller: _stepNavScroll,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: steps.length,
        itemBuilder: (ctx, i) {
          final isActive = i == currentIdx;
          final isDone = i < currentIdx;
          return GestureDetector(
            onTap: isDone
                ? () {
                    final stepName = steps[i];
                    final originalIdx = ALL_STEPS.indexOf(stepName) + 1;
                    _goStep(originalIdx);
                  }
                : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.accentBg.withOpacity(0.5)
                    : Colors.transparent,
                border: Border(
                    bottom: BorderSide(
                  color: isActive ? AppColors.accent : Colors.transparent,
                  width: 2.5,
                )),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.accent
                          : isDone
                              ? AppColors.success
                              : AppColors.border,
                      shape: BoxShape.circle,
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                  color: AppColors.accent.withOpacity(0.3),
                                  blurRadius: 6,
                                  spreadRadius: 1)
                            ]
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      isDone ? '✓' : '${i + 1}',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: (isActive || isDone)
                            ? Colors.white
                            : AppColors.muted,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    steps[i],
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: isActive ? FontWeight.w800 : FontWeight.w500,
                      color: isActive
                          ? AppColors.accent
                          : isDone
                              ? AppColors.success
                              : AppColors.muted,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ─── READINESS BANNER ───────────────────────────────────────────────────────
  Widget _buildReadinessBanner() {
    final pct = _form.calcReadiness().clamp(0, 100);
    final progressVal = (pct / 100.0).clamp(0.0, 1.0);
    final req = REQ_CERTS[_form.category] ?? [];
    final done = req.where((c) => _form.certs.contains(c)).length;
    final missing = req.where((c) => !_form.certs.contains(c)).toList();
    final isGood = pct >= 80;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isGood ? AppColors.successBg : AppColors.goldBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isGood ? const Color(0xFFC0DD97) : const Color(0xFFFAC775)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${isGood ? '🟢' : '🟡'} You are $pct% job-ready',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: isGood
                              ? const Color(0xFF27500A)
                              : AppColors.goldText),
                    ),
                    Text('$done/${req.length} required certs',
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.muted)),
                  ],
                ),
                const SizedBox(height: 7),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: progressVal,
                    minHeight: 7,
                    backgroundColor: AppColors.border,
                    valueColor: AlwaysStoppedAnimation(
                      pct >= 80
                          ? AppColors.success
                          : pct >= 50
                              ? AppColors.gold
                              : AppColors.accent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (missing.isNotEmpty) ...[
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                'Complete "${missing.first}" to unlock more jobs',
                style: const TextStyle(
                    fontSize: 11, color: AppColors.goldText, height: 1.4),
                maxLines: 2,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ─── NAV FOOTER ─────────────────────────────────────────────────────────────
  Widget _buildNavFooter() {
    final isLast = _step == 12;
    final enabled = _isNextEnabled();
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 14, 20, MediaQuery.of(context).padding.bottom + 14),
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.border)),
        boxShadow: [
          BoxShadow(
              color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, -2))
        ],
      ),
      child: Row(
        children: [
          OutlinedButton(
            onPressed: _step == 1 ? null : _prevStep,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textSub,
              side: const BorderSide(color: AppColors.border),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('← Back',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ),
          const Spacer(),
          // OutlinedButton(
          //   onPressed: _saveDraft,
          //   style: OutlinedButton.styleFrom(
          //     foregroundColor: AppColors.textSub,
          //     side: const BorderSide(color: AppColors.border),
          //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12)),
          //   ),
          //   child: const Text('💾 Save Draft',
          //       style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          // ),
          const SizedBox(width: 10),
          AnimatedOpacity(
            opacity: enabled ? 1.0 : 0.5,
            duration: const Duration(milliseconds: 200),
            child: ElevatedButton(
              onPressed: enabled ? _nextStep : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Text(
                isLast ? '🚀 Submit Profile' : 'Continue →',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── STEP ROUTER ────────────────────────────────────────────────────────────
  Widget _buildCurrentStep() {
    switch (_step) {
      case 1:
        return Step1Widget(
            form: _form, workerId: _workerId, onChanged: () => setState(() {}));
      case 2:
        return Step2Widget(form: _form, onChanged: () => setState(() {}));
      case 3:
        return Step3Widget(form: _form, onChanged: () => setState(() {}));
      case 4:
        return Step4Widget(form: _form, onChanged: () => setState(() {}));
      case 5:
        return Step5Widget(form: _form, onChanged: () => setState(() {}));
      case 6:
        return Step6Widget(form: _form, onChanged: () => setState(() {}));
      case 7:
        return Step7Widget(form: _form, onChanged: () => setState(() {}));
      case 8:
        return Step8Widget(form: _form, onChanged: () => setState(() {}));
      case 9:
        return Step9Widget(form: _form, onChanged: () => setState(() {}));
      case 10:
        return Step10Widget(form: _form, onChanged: () => setState(() {}));
      case 11:
        return Step11Widget(form: _form, onChanged: () => setState(() {}));
      case 12:
        return Step12Widget(
            form: _form, workerId: _workerId, onChanged: () => setState(() {}));
      default:
        return const SizedBox();
    }
  }

  // ─── SUCCESS SCREEN ─────────────────────────────────────────────────────────
  Widget _buildSuccessScreen() {
    final pct = _form.calcReadiness();
    final req = REQ_CERTS[_form.category] ?? [];
    final missing = req.where((c) => !_form.certs.contains(c)).toList();
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            builder: (ctx, v, child) => Opacity(
              opacity: v,
              child: Transform.translate(
                  offset: Offset(0, (1 - v) * 20), child: child),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.elasticOut,
                  builder: (_, v, child) =>
                      Transform.scale(scale: v, child: child),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.accentBg,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.accent, width: 2),
                    ),
                    alignment: Alignment.center,
                    child: const Text('✓',
                        style: TextStyle(
                            color: AppColors.accent,
                            fontSize: 34,
                            fontWeight: FontWeight.w900)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Profile Submitted!',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textColor,
                        letterSpacing: 0.5)),
                const SizedBox(height: 8),
                const Text(
                  "Your BACKUPP workforce profile has been created and is currently under review. You'll be notified once approved.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.textSub, fontSize: 14, height: 1.6),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      const Text('Your Worker ID',
                          style:
                              TextStyle(fontSize: 12, color: AppColors.muted)),
                      const SizedBox(height: 4),
                      Text(_workerId,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: AppColors.accent,
                              letterSpacing: 2)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: pct >= 80 ? AppColors.successBg : AppColors.goldBg,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${pct >= 80 ? '🟢' : '🟡'} Job Readiness: $pct%',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: pct >= 80
                                  ? const Color(0xFF27500A)
                                  : AppColors.goldText)),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: (pct / 100.0).clamp(0.0, 1.0),
                          minHeight: 7,
                          backgroundColor: AppColors.border,
                          valueColor: AlwaysStoppedAnimation(
                              pct >= 80 ? AppColors.success : AppColors.gold),
                        ),
                      ),
                      if (missing.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                            'Complete "${missing.first}" to unlock more job opportunities.',
                            style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.goldText,
                                height: 1.5)),
                      ] else ...[
                        const SizedBox(height: 8),
                        const Text(
                            "All required certifications complete — you're fully job-ready!",
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF27500A),
                                height: 1.5)),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: const Text('+ Register Another Profile',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── SHARED WIDGETS ───────────────────────────────────────────────────────────
class StepHeading extends StatelessWidget {
  final String title, subtitle;
  const StepHeading({super.key, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textColor,
                  letterSpacing: 0.3)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textSub, height: 1.5)),
          const SizedBox(height: 20),
        ],
      );
}

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const AppCard({super.key, required this.child, this.padding});
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: padding ?? const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: child,
      );
}

class CardTitle extends StatelessWidget {
  final String title;
  const CardTitle(this.title, {super.key});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(bottom: 14),
        margin: const EdgeInsets.only(bottom: 14),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.border))),
        child: Text(title,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.textColor,
                letterSpacing: 0.3)),
      );
}

class AppTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final String value;
  final bool required;
  final bool obscure;
  final TextInputType? keyboardType;
  final Function(String) onChanged;
  const AppTextField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.hint,
    this.required = true,
    this.obscure = false,
    this.keyboardType,
  });
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor)),
              if (required)
                const Text(' *', style: TextStyle(color: AppColors.danger)),
            ]),
            const SizedBox(height: 6),
            TextFormField(
              initialValue: value,
              obscureText: obscure,
              keyboardType: keyboardType,
              onChanged: onChanged,
              style: const TextStyle(fontSize: 14, color: AppColors.textColor),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle:
                    const TextStyle(color: AppColors.muted, fontSize: 13),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.border)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.border)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: AppColors.accent, width: 1.5)),
                filled: true,
                fillColor: AppColors.card,
              ),
            ),
          ],
        ),
      );
}

class PillButton extends StatelessWidget {
  final String label;
  final bool active;
  final bool solid;
  final VoidCallback onTap;
  const PillButton(
      {super.key,
      required this.label,
      required this.active,
      required this.onTap,
      this.solid = false});
  @override
  Widget build(BuildContext context) {
    Color bg = AppColors.card;
    Color border = AppColors.border;
    Color text = AppColors.textSub;
    if (active && solid) {
      bg = AppColors.accent;
      border = AppColors.accent;
      text = Colors.white;
    } else if (active) {
      bg = AppColors.accentBg;
      border = AppColors.accent;
      text = AppColors.accentDim;
    }
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: border, width: 1.5),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 13,
                fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                color: text)),
      ),
    );
  }
}

// ─── STEP 1: ACCOUNT ─────────────────────────────────────────────────────────
class Step1Widget extends StatefulWidget {
  final FormState form;
  final String workerId;
  final VoidCallback onChanged;
  const Step1Widget(
      {super.key,
      required this.form,
      required this.workerId,
      required this.onChanged});
  @override
  State<Step1Widget> createState() => _Step1WidgetState();
}

class _Step1WidgetState extends State<Step1Widget> {
  bool _showPass = false, _showConfirmPass = false;
  @override
  Widget build(BuildContext context) {
    final f = widget.form;
    final emailErr = f.email.isNotEmpty &&
        f.confirmEmail.isNotEmpty &&
        f.email != f.confirmEmail;
    final passErr = f.password.isNotEmpty &&
        f.confirmPassword.isNotEmpty &&
        f.password != f.confirmPassword;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StepHeading(
            title: 'Create Your Account',
            subtitle: 'Your Worker ID: ${widget.workerId}'),
        AppCard(
            child: Column(children: [
          Row(children: [
            Expanded(
                child: AppTextField(
                    label: 'First Name',
                    value: f.firstName,
                    onChanged: (v) {
                      f.firstName = v;
                      widget.onChanged();
                    })),
            const SizedBox(width: 14),
            Expanded(
                child: AppTextField(
                    label: 'Last Name',
                    value: f.lastName,
                    onChanged: (v) {
                      f.lastName = v;
                      widget.onChanged();
                    })),
          ]),
          AppTextField(
              label: 'Mobile Number',
              hint: '+61 4xx xxx xxx',
              value: f.mobile,
              keyboardType: TextInputType.phone,
              onChanged: (v) {
                f.mobile = v;
                widget.onChanged();
              }),
          AppTextField(
              label: 'Email Address',
              value: f.email,
              keyboardType: TextInputType.emailAddress,
              onChanged: (v) {
                f.email = v;
                widget.onChanged();
              }),
          AppTextField(
              label: 'Confirm Email',
              value: f.confirmEmail,
              keyboardType: TextInputType.emailAddress,
              onChanged: (v) {
                f.confirmEmail = v;
                widget.onChanged();
              }),
          if (emailErr)
            const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text('Emails do not match',
                    style: TextStyle(color: AppColors.danger, fontSize: 11))),
          _passwordField('Password', f.password, _showPass,
              () => setState(() => _showPass = !_showPass), (v) {
            f.password = v;
            widget.onChanged();
          }),
          _passwordField(
              'Confirm Password',
              f.confirmPassword,
              _showConfirmPass,
              () => setState(() => _showConfirmPass = !_showConfirmPass), (v) {
            f.confirmPassword = v;
            widget.onChanged();
          }),
          if (passErr)
            const Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text('Passwords do not match',
                    style: TextStyle(color: AppColors.danger, fontSize: 11))),
        ])),
      ],
    );
  }

  Widget _passwordField(String label, String value, bool show,
      VoidCallback toggle, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor)),
          const Text(' *', style: TextStyle(color: AppColors.danger)),
        ]),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: value,
          obscureText: !show,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.border)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.border)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: AppColors.accent, width: 1.5)),
            filled: true,
            fillColor: AppColors.card,
            suffixIcon: IconButton(
                onPressed: toggle,
                icon: Icon(show ? Icons.visibility_off : Icons.visibility,
                    size: 18, color: AppColors.muted)),
          ),
        ),
      ]),
    );
  }
}

// ─── STEP 2: PROFILE TYPE ────────────────────────────────────────────────────
class Step2Widget extends StatelessWidget {
  final FormState form;
  final VoidCallback onChanged;
  const Step2Widget({super.key, required this.form, required this.onChanged});
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StepHeading(
              title: 'Profile Type', subtitle: 'How will you use BACKUPP?'),
          Row(children: [
            Expanded(
                child: _typeCard('Job Seeker', '🔍',
                    'Find casual, part-time or full-time work across industries')),
            const SizedBox(width: 14),
            Expanded(
                child: _typeCard('Service Provider', '🏢',
                    'Register your services and get matched directly to job opportunities')),
          ]),
        ],
      );
  Widget _typeCard(String type, String icon, String desc) {
    final active = form.profileType == type;
    return GestureDetector(
      onTap: () {
        form.profileType = type;
        onChanged();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: active ? AppColors.accentBg : AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: active ? AppColors.accent : AppColors.border, width: 2),
        ),
        child: Column(children: [
          Text(icon, style: const TextStyle(fontSize: 36)),
          const SizedBox(height: 10),
          Text(type,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: active ? AppColors.accentDim : AppColors.textColor)),
          const SizedBox(height: 6),
          Text(desc,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 11.5, color: AppColors.textSub, height: 1.5)),
        ]),
      ),
    );
  }
}

// ─── STEP 3: SERVICES ────────────────────────────────────────────────────────
class Step3Widget extends StatelessWidget {
  final FormState form;
  final VoidCallback onChanged;
  const Step3Widget({super.key, required this.form, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    final cat = CATEGORIES.where((c) => c.id == form.category).firstOrNull;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const StepHeading(
          title: 'Select Your Service',
          subtitle:
              'Choose one category — you can manage others after registration.'),
      GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.1,
        children: CATEGORIES.map((c) {
          final active = form.category == c.id;
          return GestureDetector(
            onTap: () {
              form.category = c.id;
              form.selectedRole = '';
              onChanged();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: active ? AppColors.accentBg : AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: active ? AppColors.accent : AppColors.border,
                    width: 2),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(c.icon, style: const TextStyle(fontSize: 22)),
                    const SizedBox(height: 4),
                    Text(c.label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: active
                                ? AppColors.accentDim
                                : AppColors.textColor,
                            height: 1.3)),
                  ]),
            ),
          );
        }).toList(),
      ),
      if (cat != null) ...[
        const SizedBox(height: 16),
        AppCard(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CardTitle('${cat.icon} ${cat.label} — Select Your Role'),
          Wrap(
              spacing: 8,
              runSpacing: 8,
              children: cat.roles
                  .map((r) => PillButton(
                        label: r,
                        solid: true,
                        active: form.selectedRole == r,
                        onTap: () {
                          form.selectedRole = r;
                          onChanged();
                        },
                      ))
                  .toList()),
        ])),
      ],
    ]);
  }
}

// ─── STEP 4: AVAILABILITY ────────────────────────────────────────────────────
class Step4Widget extends StatelessWidget {
  final FormState form;
  final VoidCallback onChanged;
  const Step4Widget({super.key, required this.form, required this.onChanged});
  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const StepHeading(
            title: 'Availability & Work Preferences',
            subtitle: "Tell employers when you're available to work."),
        AppCard(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CardTitle('💼 Employment Type'),
          Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  ['Full-Time', 'Part-Time', 'Casual', 'Shift-Based', 'On-Call']
                      .map((o) => PillButton(
                            label: o,
                            active: form.employmentType.contains(o),
                            onTap: () {
                              form.toggleList('employmentType', o);
                              onChanged();
                            },
                          ))
                      .toList()),
        ])),
        AppCard(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CardTitle('📅 Available Days'),
          Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                  .map((o) => PillButton(
                        label: o,
                        active: form.days.contains(o),
                        onTap: () {
                          form.toggleList('days', o);
                          onChanged();
                        },
                      ))
                  .toList()),
        ])),
        AppCard(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CardTitle('🕐 Preferred Time Slots'),
          Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                'Early Morning (5–8am)',
                'Morning (8am–12pm)',
                'Afternoon (12–5pm)',
                'Evening (5–9pm)',
                'Night (9pm+)'
              ]
                  .map((o) => PillButton(
                        label: o.split('(').first.trim(),
                        active: form.timeSlots.contains(o),
                        onTap: () {
                          form.toggleList('timeSlots', o);
                          onChanged();
                        },
                      ))
                  .toList()),
        ])),
        AppCard(
            child: Column(children: [
          const CardTitle('📆 Custom Date Availability'),
          Row(children: [
            Expanded(
                child: _dateField('Available From', form.dateFrom, (v) {
              form.dateFrom = v;
              onChanged();
            })),
            const SizedBox(width: 14),
            Expanded(
                child: _dateField('Available Until', form.dateTo, (v) {
              form.dateTo = v;
              onChanged();
            })),
          ]),
        ])),
      ]);
  Widget _dateField(String label, String value, Function(String) onChanged) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor)),
          const SizedBox(height: 6),
          TextFormField(
            initialValue: value,
            keyboardType: TextInputType.datetime,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: 'DD/MM/YYYY',
              hintStyle: const TextStyle(color: AppColors.muted, fontSize: 13),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.border)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.border)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: AppColors.accent, width: 1.5)),
              filled: true,
              fillColor: AppColors.card,
            ),
          ),
        ],
      );
}

// ─── STEP 5: EXPERIENCE ──────────────────────────────────────────────────────
class Step5Widget extends StatelessWidget {
  final FormState form;
  final VoidCallback onChanged;
  const Step5Widget({super.key, required this.form, required this.onChanged});
  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const StepHeading(
            title: 'Work Experience',
            subtitle:
                'Add your previous work history — more detail increases your job-readiness score.'),
        AppCard(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CardTitle('🏷️ Prior Experience'),
          Wrap(
              spacing: 8,
              children: ['Yes', 'No']
                  .map((o) => PillButton(
                        label: o,
                        solid: true,
                        active: form.hasExperience == o,
                        onTap: () {
                          form.hasExperience = o;
                          if (o == 'Yes' && form.experiences.isEmpty) {
                            form.experiences.add({
                              'employer': '',
                              'company': '',
                              'contact': '',
                              'address': '',
                              'title': '',
                              'duties': ''
                            });
                          }
                          onChanged();
                        },
                      ))
                  .toList()),
        ])),
        if (form.hasExperience == 'Yes') ...[
          ...form.experiences.asMap().entries.map((entry) {
            final i = entry.key;
            final e = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Experience ${i + 1}',
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textSub)),
                          if (form.experiences.length > 1)
                            TextButton(
                                onPressed: () {
                                  form.experiences.removeAt(i);
                                  onChanged();
                                },
                                child: const Text('— Remove',
                                    style: TextStyle(
                                        color: AppColors.danger,
                                        fontSize: 12))),
                        ]),
                    Row(children: [
                      Expanded(
                          child: _expField(
                              'Employer / Supervisor', e['employer']!, (v) {
                        form.experiences[i]['employer'] = v;
                        onChanged();
                      })),
                      const SizedBox(width: 14),
                      Expanded(
                          child: _expField('Company Name', e['company']!, (v) {
                        form.experiences[i]['company'] = v;
                        onChanged();
                      })),
                    ]),
                    Row(children: [
                      Expanded(
                          child:
                              _expField('Contact Details', e['contact']!, (v) {
                        form.experiences[i]['contact'] = v;
                        onChanged();
                      })),
                      const SizedBox(width: 14),
                      Expanded(
                          child: _expField('Work Address', e['address']!, (v) {
                        form.experiences[i]['address'] = v;
                        onChanged();
                      })),
                    ]),
                    _expField('Job Title', e['title']!, (v) {
                      form.experiences[i]['title'] = v;
                      onChanged();
                    }),
                    _textareaField('Duties & Responsibilities', e['duties']!,
                        (v) {
                      form.experiences[i]['duties'] = v;
                      onChanged();
                    }),
                  ]),
            );
          }),
          GestureDetector(
            onTap: () {
              form.experiences.add({
                'employer': '',
                'company': '',
                'contact': '',
                'address': '',
                'title': '',
                'duties': ''
              });
              onChanged();
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.accent,
                      width: 1.5,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(12)),
              alignment: Alignment.center,
              child: const Text('+ Add Another Experience',
                  style: TextStyle(
                      color: AppColors.accent,
                      fontSize: 13,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ]);
  Widget _expField(String label, String value, Function(String) onChanged) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor)),
          const SizedBox(height: 5),
          TextFormField(
            initialValue: value,
            onChanged: onChanged,
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.border)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.border)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: AppColors.accent, width: 1.5)),
              filled: true,
              fillColor: AppColors.card,
            ),
          ),
        ]),
      );
  Widget _textareaField(
          String label, String value, Function(String) onChanged) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor)),
          const SizedBox(height: 5),
          TextFormField(
            initialValue: value,
            onChanged: onChanged,
            maxLines: 3,
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Describe your key responsibilities...',
              hintStyle: const TextStyle(color: AppColors.muted, fontSize: 12),
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.border)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.border)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: AppColors.accent, width: 1.5)),
              filled: true,
              fillColor: AppColors.card,
            ),
          ),
        ]),
      );
}

// ─── STEP 6: EDUCATION ───────────────────────────────────────────────────────
class Step6Widget extends StatelessWidget {
  final FormState form;
  final VoidCallback onChanged;
  const Step6Widget({super.key, required this.form, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    const levels = [
      'Year 10 / Equivalent',
      'Year 12 / Equivalent',
      'Certificate / Diploma',
      "Bachelor's Degree",
      'Postgraduate',
      'Other'
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const StepHeading(
          title: 'Education',
          subtitle: 'Select your highest completed level of education.'),
      AppCard(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const CardTitle('🎓 Highest Level of Education'),
        Wrap(
            spacing: 8,
            runSpacing: 8,
            children: levels
                .map((l) => PillButton(
                      label: l,
                      solid: true,
                      active: form.education == l,
                      onTap: () {
                        form.education = l;
                        onChanged();
                      },
                    ))
                .toList()),
      ])),
    ]);
  }
}

// ─── STEP 7: CERTIFICATIONS ──────────────────────────────────────────────────
class Step7Widget extends StatelessWidget {
  final FormState form;
  final VoidCallback onChanged;
  const Step7Widget({super.key, required this.form, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    final cat = CATEGORIES.where((c) => c.id == form.category).firstOrNull;
    final certs = form.category.isNotEmpty
        ? (CAT_CERTS[form.category] ?? [])
        : [
            'Certificate III',
            'Certificate IV',
            'White Card',
            'RSA Certificate',
            'Food Safety Certificate',
            'Security Licence',
            'First Aid Certificate',
            'CPR Certificate',
            'NDIS Worker Screening',
            'Working With Children Check',
            'Police Check',
            'Forklift Licence'
          ];
    final req = form.category.isNotEmpty
        ? (REQ_CERTS[form.category] ?? [])
        : <String>[];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      StepHeading(
          title: 'Certifications',
          subtitle: cat != null
              ? 'Certifications for ${cat.label}'
              : 'Select all certifications you currently hold.'),
      if (req.isNotEmpty)
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: AppColors.goldBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFAC775))),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Required for ${cat?.label}:',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.goldText)),
            const SizedBox(height: 8),
            Wrap(
                spacing: 6,
                runSpacing: 6,
                children: req.map((r) {
                  final have = form.certs.contains(r);
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: have ? AppColors.successBg : AppColors.dangerBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('${have ? '✓' : '✗'} $r',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: have
                                ? const Color(0xFF27500A)
                                : const Color(0xFF791F1F))),
                  );
                }).toList()),
          ]),
        ),
      AppCard(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const CardTitle('📋 Your Certifications'),
        ...certs.map((c) {
          final checked = form.certs.contains(c);
          final isReq = req.contains(c);
          return GestureDetector(
            onTap: () {
              form.toggleList('certs', c);
              onChanged();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: checked ? AppColors.accentBg : AppColors.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: checked ? AppColors.accent : AppColors.border),
              ),
              child: Row(children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: checked ? AppColors.accent : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: checked ? AppColors.accent : AppColors.muted,
                        width: 1.5),
                  ),
                  alignment: Alignment.center,
                  child: checked
                      ? const Icon(Icons.check, size: 11, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(c,
                        style: TextStyle(
                            fontSize: 13,
                            color: checked
                                ? AppColors.accentDim
                                : AppColors.textColor,
                            fontWeight:
                                checked ? FontWeight.w600 : FontWeight.w400))),
                if (isReq)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                        color: AppColors.goldBg,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text('Required',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.goldText)),
                  ),
              ]),
            ),
          );
        }),
      ])),
    ]);
  }
}

// ─── REUSABLE UPLOAD ZONE WIDGET ─────────────────────────────────────────────
class UploadZoneWidget extends StatefulWidget {
  final String hint;
  final String icon;
  const UploadZoneWidget(
      {super.key, this.hint = 'Click to upload document', this.icon = '📄'});
  @override
  State<UploadZoneWidget> createState() => _UploadZoneWidgetState();
}

class _UploadZoneWidgetState extends State<UploadZoneWidget>
    with SingleTickerProviderStateMixin {
  // Simulated upload state (real app would use file_picker package)
  String? _fileName;
  bool _uploading = false;
  bool _uploaded = false;
  double _progress = 0;
  late AnimationController _progressCtrl;

  @override
  void initState() {
    super.initState();
    _progressCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800));
    _progressCtrl
        .addListener(() => setState(() => _progress = _progressCtrl.value));
    _progressCtrl.addStatusListener((s) {
      if (s == AnimationStatus.completed)
        setState(() {
          _uploading = false;
          _uploaded = true;
        });
    });
  }

  @override
  void dispose() {
    _progressCtrl.dispose();
    super.dispose();
  }

  void _simulateUpload(String name) {
    setState(() {
      _fileName = name;
      _uploading = true;
      _uploaded = false;
      _progress = 0;
    });
    _progressCtrl.reset();
    _progressCtrl.forward();
  }

  void _pickFile() {
    // Simulate picking — in production use file_picker package
    final fakeFiles = [
      'visa_document.pdf',
      'passport_scan.jpg',
      'residency_permit.pdf',
      'work_visa.png'
    ];
    final fake = fakeFiles[DateTime.now().second % fakeFiles.length];
    _simulateUpload(fake);
  }

  void _removeFile() {
    setState(() {
      _fileName = null;
      _uploaded = false;
      _uploading = false;
      _progress = 0;
    });
    _progressCtrl.reset();
  }

  @override
  Widget build(BuildContext context) {
    if (_uploaded && _fileName != null) {
      // Uploaded state
      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.accentBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.accent, width: 1.5),
        ),
        child: Row(children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: const Icon(Icons.insert_drive_file_rounded,
                color: AppColors.accent, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(_fileName!,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textColor),
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Row(children: [
                  const Icon(Icons.check_circle,
                      size: 13, color: AppColors.success),
                  const SizedBox(width: 4),
                  const Text('Uploaded successfully',
                      style: TextStyle(fontSize: 11, color: AppColors.success)),
                ]),
              ])),
          const SizedBox(width: 8),
          // Replace button
          GestureDetector(
            onTap: _pickFile,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                  color: AppColors.accentBg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.accent)),
              child: const Text('Replace',
                  style: TextStyle(
                      fontSize: 11,
                      color: AppColors.accentDim,
                      fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(width: 6),
          // Remove button
          GestureDetector(
            onTap: _removeFile,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: AppColors.dangerBg,
                  borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.close, size: 14, color: AppColors.danger),
            ),
          ),
        ]),
      );
    }

    if (_uploading) {
      // Uploading state
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Icon(Icons.upload_rounded, size: 16, color: AppColors.accent),
            const SizedBox(width: 8),
            Expanded(
                child: Text(_fileName!,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor),
                    overflow: TextOverflow.ellipsis)),
            Text('${(_progress * 100).round()}%',
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.accent)),
          ]),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _progress.clamp(0.0, 1.0),
              minHeight: 5,
              backgroundColor: AppColors.border,
              valueColor: const AlwaysStoppedAnimation(AppColors.accent),
            ),
          ),
          const SizedBox(height: 6),
          const Text('Uploading...',
              style: TextStyle(fontSize: 11, color: AppColors.muted)),
        ]),
      );
    }

    // Idle state
    return GestureDetector(
      onTap: _pickFile,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(
              color: AppColors.accent.withOpacity(0.4),
              width: 1.5,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
                color: AppColors.accentBg, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(widget.icon, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(height: 10),
          Text(widget.hint,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor)),
          const SizedBox(height: 4),
          const Text('PDF, JPG, PNG — max 10MB',
              style: TextStyle(fontSize: 11, color: AppColors.muted)),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
            decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(20)),
            child: const Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.upload_rounded, size: 15, color: Colors.white),
              SizedBox(width: 6),
              Text('Select File',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ]),
          ),
        ]),
      ),
    );
  }
}

// ─── STEP 8: WORK RIGHTS ─────────────────────────────────────────────────────
class Step8Widget extends StatelessWidget {
  final FormState form;
  final VoidCallback onChanged;
  const Step8Widget({super.key, required this.form, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    const options = [
      'Australian Citizen',
      'Permanent Resident',
      'Temporary Resident',
      'Student Visa',
      'Working Holiday Visa',
      'Other'
    ];
    const noDocs = ['Australian Citizen', 'Permanent Resident'];
    final needsDoc =
        form.workRights.isNotEmpty && !noDocs.contains(form.workRights);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const StepHeading(
          title: 'Work Rights / Visa Status',
          subtitle: 'Confirm your legal right to work in Australia.'),
      AppCard(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const CardTitle('🇦🇺 Work Rights in Australia'),
        Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options
                .map((o) => PillButton(
                      label: o,
                      solid: true,
                      active: form.workRights == o,
                      onTap: () {
                        form.workRights = o;
                        onChanged();
                      },
                    ))
                .toList()),
      ])),
      if (needsDoc)
        AppCard(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CardTitle('📎 Upload Visa Documentation'),
          const UploadZoneWidget(
              hint: 'Click to upload your visa documents', icon: '✈️'),
        ])),
    ]);
  }
}

// ─── STEP 9: ID CHECK ────────────────────────────────────────────────────────
class Step9Widget extends StatefulWidget {
  final FormState form;
  final VoidCallback onChanged;
  const Step9Widget({super.key, required this.form, required this.onChanged});
  @override
  State<Step9Widget> createState() => _Step9WidgetState();
}

class _Step9WidgetState extends State<Step9Widget> {
  // Keep one UploadZoneWidget per doc so state is preserved
  final Map<String, GlobalKey<_UploadZoneWidgetState>> _uploadKeys = {};

  static const _docs = [
    {'label': 'Passport', 'pts': '70', 'icon': '🛂'},
    {'label': "Driver's Licence", 'pts': '40', 'icon': '🪪'},
    {'label': 'Medicare Card', 'pts': '25', 'icon': '💳'},
    {'label': 'Utility Bill', 'pts': '25', 'icon': '📬'},
    {'label': 'Birth Certificate', 'pts': '50', 'icon': '📜'},
    {'label': 'Visa Copy', 'pts': '40', 'icon': '✈️'},
  ];

  @override
  void initState() {
    super.initState();
    for (final d in _docs) {
      _uploadKeys[d['label']!] = GlobalKey<_UploadZoneWidgetState>();
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = _docs
        .where((d) => widget.form.idDocs.contains(d['label']))
        .fold(0, (s, d) => s + int.parse(d['pts']!));
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const StepHeading(
          title: '100 Point ID Verification',
          subtitle:
              'Select a document card then upload the file to collect points.'),
      AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: total >= 100 ? AppColors.successBg : AppColors.accentBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: total >= 100
                  ? const Color(0xFFC0DD97)
                  : AppColors.accent.withOpacity(0.3)),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Points Collected',
              style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSub,
                  fontWeight: FontWeight.w600)),
          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: total),
            duration: const Duration(milliseconds: 400),
            builder: (_, v, __) => Text('$v / 100 pts',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color:
                        total >= 100 ? AppColors.success : AppColors.accent)),
          ),
        ]),
      ),
      // Doc cards grid
      GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.55,
        children: _docs.map((d) {
          final active = widget.form.idDocs.contains(d['label']);
          return GestureDetector(
            onTap: () {
              widget.form.toggleList('idDocs', d['label']!);
              widget.onChanged();
              setState(() {});
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: active ? AppColors.accentBg : AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: active ? AppColors.accent : AppColors.border,
                    width: 2),
                boxShadow: active
                    ? [
                        BoxShadow(
                            color: AppColors.accent.withOpacity(0.15),
                            blurRadius: 8,
                            spreadRadius: 1)
                      ]
                    : null,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(d['icon']!,
                              style: const TextStyle(fontSize: 20)),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 3),
                            decoration: BoxDecoration(
                              color: active
                                  ? const Color(0xFFC2F0EA)
                                  : AppColors.surface,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text('${d['pts']} pts',
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    color: active
                                        ? AppColors.accentDim
                                        : AppColors.muted)),
                          ),
                        ]),
                    const SizedBox(height: 5),
                    Text(d['label']!,
                        style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: active
                                ? AppColors.accentDim
                                : AppColors.textColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Row(children: [
                      Icon(
                          active
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          size: 12,
                          color: active ? AppColors.success : AppColors.muted),
                      const SizedBox(width: 3),
                      Text(active ? 'Selected' : 'Tap to select',
                          style: TextStyle(
                              fontSize: 10,
                              color: active
                                  ? AppColors.success
                                  : AppColors.muted)),
                    ]),
                  ]),
            ),
          );
        }).toList(),
      ),
      // Upload zones for selected docs
      if (widget.form.idDocs.isNotEmpty) ...[
        const SizedBox(height: 20),
        const Text('Upload Selected Documents',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColors.textColor)),
        const SizedBox(height: 4),
        const Text('Upload a file for each selected document below.',
            style: TextStyle(fontSize: 12, color: AppColors.textSub)),
        const SizedBox(height: 14),
        ...widget.form.idDocs.map((docLabel) {
          final doc = _docs.firstWhere((d) => d['label'] == docLabel,
              orElse: () => {'label': docLabel, 'icon': '📄', 'pts': '0'});
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(doc['icon']!, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Text(doc['label']!,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textColor)),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                      color: AppColors.accentBg,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text('${doc['pts']} pts',
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.accentDim)),
                ),
              ]),
              const SizedBox(height: 8),
              UploadZoneWidget(
                  key: _uploadKeys[docLabel],
                  hint: 'Upload ${doc['label']}',
                  icon: doc['icon']!),
            ]),
          );
        }),
      ],
    ]);
  }
}

// ─── STEP 10: ENHANCEMENTS ───────────────────────────────────────────────────
class Step10Widget extends StatefulWidget {
  final FormState form;
  final VoidCallback onChanged;
  const Step10Widget({super.key, required this.form, required this.onChanged});
  @override
  State<Step10Widget> createState() => _Step10WidgetState();
}

class _Step10WidgetState extends State<Step10Widget> {
  bool _photoUploaded = false;
  bool _photoUploading = false;
  double _photoProgress = 0;
  String? _photoName;

  void _pickPhoto() {
    setState(() {
      _photoUploading = true;
      _photoUploaded = false;
      _photoProgress = 0;
      _photoName = 'profile_photo.jpg';
    });
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 40));
      if (!mounted) return false;
      setState(() {
        _photoProgress += 0.04;
      });
      if (_photoProgress >= 1.0) {
        setState(() {
          _photoUploading = false;
          _photoUploaded = true;
          _photoProgress = 1.0;
        });
        return false;
      }
      return true;
    });
  }

  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const StepHeading(
            title: 'Profile Enhancements',
            subtitle:
                'Stand out to employers with a complete, detailed profile.'),
        AppCard(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CardTitle('📸 Profile Photo'),
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            // Avatar
            Stack(children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _photoUploaded ? AppColors.accentBg : AppColors.surface,
                  border: Border.all(
                      color:
                          _photoUploaded ? AppColors.accent : AppColors.border,
                      width: 2),
                ),
                alignment: Alignment.center,
                child: _photoUploaded
                    ? const Icon(Icons.person_rounded,
                        size: 36, color: AppColors.accent)
                    : const Text('👤', style: TextStyle(fontSize: 28)),
              ),
              if (_photoUploaded)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                        color: AppColors.success, shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child:
                        const Icon(Icons.check, size: 12, color: Colors.white),
                  ),
                ),
            ]),
            const SizedBox(width: 16),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  if (_photoUploading) ...[
                    Text(_photoName ?? '',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textColor),
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: _photoProgress.clamp(0.0, 1.0),
                        minHeight: 5,
                        backgroundColor: AppColors.border,
                        valueColor:
                            const AlwaysStoppedAnimation(AppColors.accent),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('Uploading... ${(_photoProgress * 100).round()}%',
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.muted)),
                  ] else if (_photoUploaded) ...[
                    const Text('Photo uploaded!',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.success)),
                    const SizedBox(height: 4),
                    Text(_photoName ?? '',
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.muted)),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: _pickPhoto,
                      style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.accent,
                          side: const BorderSide(color: AppColors.accent),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 7),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Text('Change Photo',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600)),
                    ),
                  ] else ...[
                    const Text('No photo uploaded yet',
                        style:
                            TextStyle(fontSize: 12, color: AppColors.textSub)),
                    const SizedBox(height: 4),
                    const Text('JPG, PNG — max 5MB',
                        style: TextStyle(fontSize: 11, color: AppColors.muted)),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: _pickPhoto,
                      icon: const Icon(Icons.upload_rounded, size: 15),
                      label: const Text('Upload Photo',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 9),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 0),
                    ),
                  ],
                ])),
          ]),
        ])),
        AppCard(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CardTitle('📝 About You'),
          _textArea('Short Bio', widget.form.bio,
              'Tell employers a little about yourself...', (v) {
            widget.form.bio = v;
            widget.onChanged();
          }),
          AppTextField(
              label: 'Skills / Tags',
              required: false,
              value: widget.form.skills,
              hint: 'e.g. Patient care, leadership, forklift operation...',
              onChanged: (v) {
                widget.form.skills = v;
                widget.onChanged();
              }),
          AppTextField(
              label: 'Languages Spoken',
              required: false,
              value: widget.form.languages,
              hint: 'e.g. English, Vietnamese, Mandarin...',
              onChanged: (v) {
                widget.form.languages = v;
                widget.onChanged();
              }),
        ])),
        AppCard(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CardTitle('💰 Work Preferences'),
          Wrap(spacing: 8, runSpacing: 0, children: [
            AppTextField(
                label: 'Preferred Hourly Rate (AUD \$)',
                required: false,
                value: widget.form.rate,
                hint: 'e.g. 28.50',
                keyboardType: TextInputType.number,
                onChanged: (v) {
                  widget.form.rate = v;
                  widget.onChanged();
                }),
            // const SizedBox(width: 14),
            AppTextField(
                label: 'Max Travel Radius (km)',
                required: false,
                value: widget.form.radius,
                hint: 'e.g. 30',
                keyboardType: TextInputType.number,
                onChanged: (v) {
                  widget.form.radius = v;
                  widget.onChanged();
                }),
          ])
          // Row(children: [

          //   Expanded(
          //       child: AppTextField(
          //           label: 'Preferred Hourly Rate (AUD \$)',
          //           required: false,
          //           value: widget.form.rate,
          //           hint: 'e.g. 28.50',
          //           keyboardType: TextInputType.number,
          //           onChanged: (v) {
          //             widget.form.rate = v;
          //             widget.onChanged();
          //           })),
          //   const SizedBox(width: 14),
          //   Expanded(
          //       child: AppTextField(
          //           label: 'Max Travel Radius (km)',
          //           required: false,
          //           value: widget.form.radius,
          //           hint: 'e.g. 30',
          //           keyboardType: TextInputType.number,
          //           onChanged: (v) {
          //             widget.form.radius = v;
          //             widget.onChanged();
          //           })),
          // ]),
        ])),
      ]);
  Widget _textArea(String label, String value, String hint,
          Function(String) onChanged) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor)),
          const SizedBox(height: 6),
          TextFormField(
            initialValue: value,
            onChanged: onChanged,
            maxLines: 3,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: AppColors.muted, fontSize: 13),
              contentPadding: const EdgeInsets.all(14),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.border)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.border)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: AppColors.accent, width: 1.5)),
              filled: true,
              fillColor: AppColors.card,
            ),
          ),
        ]),
      );
}

// ─── STEP 11: COMPLIANCE ─────────────────────────────────────────────────────
class Step11Widget extends StatelessWidget {
  final FormState form;
  final VoidCallback onChanged;
  const Step11Widget({super.key, required this.form, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    final checks = [
      {
        'key': 'policeCheck',
        'label': 'Police Check',
        'desc':
            'Required for most roles in Australia. Valid for 12 months from issue date.',
        'icon': '🚔'
      },
      {
        'key': 'wwcc',
        'label': 'Working With Children Check (WWCC)',
        'desc':
            'Mandatory for all roles involving children, education, and youth services.',
        'icon': '👶'
      },
      {
        'key': 'ndis',
        'label': 'NDIS Worker Screening Check',
        'desc':
            'Required for all NDIS-funded disability support and community care roles.',
        'icon': '♿'
      },
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const StepHeading(
          title: 'Compliance Checks',
          subtitle:
              'Confirm which compliance checks you have completed or are willing to obtain.'),
      ...checks.map((c) {
        final key = c['key']!;
        String val = '';
        if (key == 'policeCheck') val = form.policeCheck;
        if (key == 'wwcc') val = form.wwcc;
        if (key == 'ndis') val = form.ndis;
        return AppCard(
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(c['icon']!, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 14),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(c['label']!,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textColor)),
                const SizedBox(height: 4),
                Text(c['desc']!,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSub, height: 1.5)),
                const SizedBox(height: 12),
                Wrap(spacing: 8, runSpacing: 8, children: [
                  PillButton(
                      label: 'Yes — I have this',
                      solid: val == 'yes',
                      active: val == 'yes',
                      onTap: () {
                        if (key == 'policeCheck') form.policeCheck = 'yes';
                        if (key == 'wwcc') form.wwcc = 'yes';
                        if (key == 'ndis') form.ndis = 'yes';
                        onChanged();
                      }),
                  PillButton(
                      label: 'No — I need to obtain',
                      active: val == 'no',
                      onTap: () {
                        if (key == 'policeCheck') form.policeCheck = 'no';
                        if (key == 'wwcc') form.wwcc = 'no';
                        if (key == 'ndis') form.ndis = 'no';
                        onChanged();
                      }),
                ]),
              ])),
        ]));
      }),
    ]);
  }
}

// ─── STEP 12: AGREEMENT ──────────────────────────────────────────────────────
class Step12Widget extends StatelessWidget {
  final FormState form;
  final String workerId;
  final VoidCallback onChanged;
  const Step12Widget(
      {super.key,
      required this.form,
      required this.workerId,
      required this.onChanged});
  @override
  Widget build(BuildContext context) {
    final cat = CATEGORIES.where((c) => c.id == form.category).firstOrNull;
    final pct = form.calcReadiness();
    final req = REQ_CERTS[form.category] ?? [];
    final missing = req.where((c) => !form.certs.contains(c)).toList();
    final summary = [
      {
        'l': 'Name',
        'v': ('${form.firstName} ${form.lastName}').trim().isNotEmpty
            ? '${form.firstName} ${form.lastName}'.trim()
            : '—'
      },
      {
        'l': 'Profile Type',
        'v': form.profileType.isNotEmpty ? form.profileType : '—'
      },
      {'l': 'Category', 'v': cat?.label ?? '—'},
      {
        'l': 'Role',
        'v': form.selectedRole.isNotEmpty ? form.selectedRole : '—'
      },
      {
        'l': 'Certifications',
        'v': form.certs.isNotEmpty ? '${form.certs.length} added' : 'None'
      },
      {'l': 'Job Readiness', 'v': '$pct%'},
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const StepHeading(
          title: 'Review & Agreement',
          subtitle:
              'Almost there — review your profile summary and confirm your details.'),
      AppCard(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const CardTitle('📊 Profile Summary'),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.6,
          children: summary
              .map((s) => Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(s['l']!,
                              style: const TextStyle(
                                  fontSize: 10, color: AppColors.muted)),
                          const SizedBox(height: 2),
                          Text(s['v']!,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textColor),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ]),
                  ))
              .toList(),
        ),
        if (form.category.isNotEmpty) ...[
          const SizedBox(height: 14),
          const Text('Job Readiness',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSub)),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: (pct / 100.0).clamp(0.0, 1.0),
              minHeight: 7,
              backgroundColor: AppColors.border,
              valueColor: AlwaysStoppedAnimation(pct >= 80
                  ? AppColors.success
                  : pct >= 50
                      ? AppColors.gold
                      : AppColors.accent),
            ),
          ),
          const SizedBox(height: 6),
          if (missing.isNotEmpty)
            Text('Complete "${missing.first}" to unlock more jobs',
                style: const TextStyle(fontSize: 12, color: AppColors.goldText))
          else
            const Text('✓ All required certifications complete',
                style: TextStyle(fontSize: 12, color: AppColors.success)),
        ],
      ])),
      AppCard(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const CardTitle('✅ Declaration'),
        _declItem(
          form.agreeTerms,
          'I agree to the Terms & Conditions and Privacy Policy of BACKUPP Workforce Platform.',
          () {
            form.agreeTerms = !form.agreeTerms;
            onChanged();
          },
        ),
        const SizedBox(height: 10),
        _declItem(
          form.confirmInfo,
          'I confirm all information provided in this profile is accurate, current, and complete to the best of my knowledge.',
          () {
            form.confirmInfo = !form.confirmInfo;
            onChanged();
          },
        ),
      ])),
    ]);
  }

  Widget _declItem(bool checked, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: checked ? AppColors.accentBg : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: checked ? AppColors.accent : AppColors.border),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 18,
            height: 18,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              color: checked ? AppColors.accent : Colors.transparent,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  color: checked ? AppColors.accent : AppColors.muted,
                  width: 1.5),
            ),
            alignment: Alignment.center,
            child: checked
                ? const Icon(Icons.check, size: 12, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textColor, height: 1.6))),
        ]),
      ),
    );
  }
}
