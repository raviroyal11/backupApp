import 'dart:convert';
import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/login/controller/job_detail_screen_controller.dart';
import 'package:zob/models/job_apply_api_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/common_snackbar.dart';
import 'package:zob/utils/const.dart';

// class JobQuestionDialog extends StatefulWidget {
//   final List<QuestionModel> questions;
//   final String jobId;

//   const JobQuestionDialog({
//     super.key,
//     required this.questions,
//     required this.jobId,
//   });

//   @override
//   State<JobQuestionDialog> createState() => _JobQuestionDialogState();
// }

// class _JobQuestionDialogState extends State<JobQuestionDialog> {
//   Map<String, dynamic> answers = {};
//   final jobDetailScreenController = Get.put(JobDetailScreenController());

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Container(
//         width: 500,
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text("Answer Questions",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 16),
//             Flexible(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: widget.questions.map((q) => buildField(q)).toList(),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: submitAnswers,
//               child: const Text("Submit"),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildField(QuestionModel q) {
//     List options = [];

//     if (q.options != null) {
//       options = List.from(jsonDecode(q.options!));
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Expanded(child: Text(q.question ?? "")),
//             if (q.required == 1)
//               const Text("*", style: TextStyle(color: Colors.red))
//           ],
//         ),

//         const SizedBox(height: 8),

//         /// TEXT
//         if (q.type == "text")
//           TextFormField(
//             onChanged: (val) => answers[q.id!] = val,
//             decoration: const InputDecoration(border: OutlineInputBorder()),
//           ),

//         /// TEXTAREA
//         if (q.type == "textarea")
//           TextFormField(
//             maxLines: 4,
//             onChanged: (val) => answers[q.id!] = val,
//             decoration: const InputDecoration(border: OutlineInputBorder()),
//           ),

//         /// CHECKBOX
//         if (q.type == "checkbox")
//           Column(
//             children: options.map<Widget>((opt) {
//               List selected = answers[q.id!] ?? [];
//               return CheckboxListTile(
//                 value: selected.contains(opt),
//                 title: Text(opt),
//                 onChanged: (val) {
//                   setState(() {
//                     if (val == true) {
//                       selected.add(opt);
//                     } else {
//                       selected.remove(opt);
//                     }
//                     answers[q.id!] = selected;
//                   });
//                 },
//               );
//             }).toList(),
//           ),

//         /// RADIO
//         if (q.type == "radio")
//           Column(
//             children: options.map<Widget>((opt) {
//               return RadioListTile(
//                 value: opt,
//                 groupValue: answers[q.id],
//                 title: Text(opt),
//                 onChanged: (val) {
//                   setState(() {
//                     answers[q.id!] = val;
//                   });
//                 },
//               );
//             }).toList(),
//           ),

//         //// DROPDOWN
//         if (q.type == "select")
//           DropdownButtonFormField(
//             value: answers[q.id],
//             decoration: const InputDecoration(
//               border: OutlineInputBorder(),
//             ),
//             hint: const Text("Select option"),
//             items: options.map<DropdownMenuItem>((opt) {
//               return DropdownMenuItem(
//                 value: opt,
//                 child: Text(opt),
//               );
//             }).toList(),
//             onChanged: (val) {
//               setState(() {
//                 answers[q.id!] = val;
//               });
//             },
//           ),

//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   Future<void> submitAnswers() async {
//     /// validation
//     for (var q in widget.questions) {
//       if (q.required == 1 && answers[q.id] == null) {
//         Get.snackbar("Error", "Please fill all required fields");
//         return;
//       }
//     }

//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse('https://backupp.com/api/v1/submitEmployerQuestionAnswersApi'),
//     );

//     final token = await SharePref().getAccessToken();

//     if (token != '') {
//       request.headers['Authorization'] = 'Bearer $token';
//     }

//     /// add answers
//     answers.forEach((key, value) {
//       if (value is List) {
//         for (var v in value) {
//           request.fields['question_${key}[]'] = v;
//         }
//       } else {
//         request.fields['question_$key'] = value.toString();
//       }
//     });

//     request.fields['job_id'] = widget.jobId;

//     var response = await request.send();

//     log("Check My Job Apply api response : 2 ${response.statusCode}");

//     if (response.statusCode == 200) {
//       Get.back();

//       Get.snackbar("Success", "Answers submitted");
//     } else {
//       Get.snackbar("Error", "Failed to submit");
//     }
//   }
// }

class JobQuestionDialog extends StatefulWidget {
  final List<QuestionModel> questions;
  final String jobId;

  const JobQuestionDialog({
    super.key,
    required this.questions,
    required this.jobId,
  });

  @override
  State<JobQuestionDialog> createState() => _JobQuestionDialogState();
}

class _JobQuestionDialogState extends State<JobQuestionDialog> {
  final Map<String, dynamic> answers = {};
  final jobDetailScreenController = Get.put(JobDetailScreenController());
  bool _isSubmitting = false;

  int get _answeredCount {
    return widget.questions.where((q) {
      final val = answers[q.id];
      if (val == null) return false;
      if (val is List) return val.isNotEmpty;
      return val.toString().trim().isNotEmpty;
    }).length;
  }

  double get _progress =>
      widget.questions.isEmpty ? 0 : _answeredCount / widget.questions.length;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        width: 500,
        constraints: const BoxConstraints(maxHeight: 620),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.2),
            width: 0.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            _buildProgressBar(context),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Column(
                  children: widget.questions
                      .map((q) => _buildField(context, q))
                      .toList(),
                ),
              ),
            ),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 16, 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.15),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF185FA5).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'JOB APPLICATION',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.08,
                      color: Color(0xFF185FA5),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Screening Questions',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close, size: 18),
            style: IconButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Theme.of(context).dividerColor.withOpacity(0.3),
                ),
              ),
              padding: const EdgeInsets.all(6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$_answeredCount of ${widget.questions.length} answered',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
              ),
              Text(
                '${(_progress * 100).round()}%',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 3,
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFF185FA5)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(BuildContext context, QuestionModel q) {
    final options =
        q.options != null ? List<String>.from(jsonDecode(q.options!)) : [];

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (q.required == 1)
                Container(
                  width: 5,
                  height: 5,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE24B4A),
                    shape: BoxShape.circle,
                  ),
                ),
              Expanded(
                child: Text(
                  q.question ?? '',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // text
          if (q.type == 'text')
            TextFormField(
              onChanged: (val) => setState(() => answers[q.id!] = val),
              style: const TextStyle(fontSize: 14),
              decoration: _inputDecoration(context, 'Enter your answer'),
            ),

          // textarea
          if (q.type == 'textarea')
            TextFormField(
              maxLines: 4,
              onChanged: (val) => setState(() => answers[q.id!] = val),
              style: const TextStyle(fontSize: 14),
              decoration: _inputDecoration(context, 'Write here...'),
            ),

          // checkbox
          if (q.type == 'checkbox')
            ...options.map((opt) {
              final selected =
                  List<String>.from(answers[q.id] ?? []).contains(opt);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    final list = List<String>.from(answers[q.id] ?? []);
                    selected ? list.remove(opt) : list.add(opt);
                    answers[q.id!] = list;
                  });
                },
                child: _OptionTile(
                    label: opt, selected: selected, isCheckbox: true),
              );
            }),

          // radio
          if (q.type == 'radio')
            ...options.map((opt) {
              final selected = answers[q.id] == opt;
              return GestureDetector(
                onTap: () => setState(() => answers[q.id!] = opt),
                child: _OptionTile(
                    label: opt, selected: selected, isCheckbox: false),
              );
            }),

          // select / dropdown
          if (q.type == 'select')
            DropdownButtonFormField<String>(
              value: answers[q.id],
              decoration: _inputDecoration(context, 'Select an option'),
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
              items: options
                  .map<DropdownMenuItem<String>>((opt) =>
                      DropdownMenuItem<String>(
                          value: opt as String,
                          child: Text(opt as String,
                              style: const TextStyle(fontSize: 14))))
                  .toList(),
              onChanged: (val) => setState(() => answers[q.id!] = val),
            ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(BuildContext context, String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: Theme.of(context).hintColor,
        fontSize: 14,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Theme.of(context).dividerColor.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Theme.of(context).dividerColor.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xFF185FA5),
          width: 1.5,
        ),
      ),
      filled: true,
      fillColor: Theme.of(context).colorScheme.surface,
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.15),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFFE24B4A),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'Required fields',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          TextButton(
            onPressed: () => Get.back(),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).hintColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: Theme.of(context).dividerColor.withOpacity(0.3),
                  width: 0.5,
                ),
              ),
            ),
            child: const Text('Cancel', style: TextStyle(fontSize: 13)),
          ),
          const SizedBox(width: 8),
          FilledButton(
            onPressed: _isSubmitting ? null : _submitAnswers,
            style: FilledButton.styleFrom(
              backgroundColor: AppColor.color77DC,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: _isSubmitting
                ? const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Submit', style: TextStyle(fontSize: 13)),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, size: 14),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitAnswers() async {
    for (var q in widget.questions) {
      if (q.required == 1 && answers[q.id] == null) {
        Get.snackbar(
          'Required fields missing',
          'Please fill all required fields marked in red',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFA32D2D),
          colorText: Colors.white,
          borderRadius: 10,
          margin: const EdgeInsets.all(16),
        );
        return;
      }
    }

    setState(() => _isSubmitting = true);

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiUrl.submitEmployerQuestionAnswersApi),
    );

    final token = await SharePref().getAccessToken();
    if (token.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    answers.forEach((key, value) {
      if (value is List) {
        for (var v in value) {
          request.fields['question_${key}[]'] = v;
        }
      } else {
        request.fields['question_$key'] = value.toString();
      }
    });

    request.fields['job_id'] = widget.jobId;

    try {
      final response = await request.send();
      log("Submit answers response status: ${response.statusCode} /// ${response.stream.transform(utf8.decoder).join()}");
      if (response.statusCode == 200) {
        Get.back();
        CommonSnackBarWidget().snackBarWidget(
          context: Get.context!,
          title: "Submitted!",
          message: "Your answers have been submitted",
          snackBarType: ContentType.success,
        );
      } else {
        throw Exception('Server error');
      }
    } catch (_) {
      CommonSnackBarWidget().snackBarWidget(
        context: Get.context!,
        title: "Submission Failed!",
        message: "Failed to submit your answers. Please try again.",
        snackBarType: ContentType.failure,
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }
}

// Reusable option tile for checkbox & radio
class _OptionTile extends StatelessWidget {
  final String label;
  final bool selected;
  final bool isCheckbox;

  const _OptionTile({
    required this.label,
    required this.selected,
    required this.isCheckbox,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: selected
            ? const Color(0xFF185FA5).withOpacity(0.08)
            : Colors.transparent,
        border: Border.all(
          color: selected
              ? const Color(0xFF185FA5).withOpacity(0.5)
              : Theme.of(context).dividerColor.withOpacity(0.2),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: selected ? const Color(0xFF185FA5) : Colors.transparent,
              border: Border.all(
                color: selected
                    ? const Color(0xFF185FA5)
                    : Theme.of(context).dividerColor.withOpacity(0.4),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(isCheckbox ? 4 : 8),
            ),
            child: selected
                ? Icon(
                    isCheckbox ? Icons.check : Icons.circle,
                    size: isCheckbox ? 11 : 8,
                    color: Colors.white,
                  )
                : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
