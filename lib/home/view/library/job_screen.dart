import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zob/home/view/job_detail_screen.dart';
import 'package:zob/home/view/library/controller/jobScreenController.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_images.dart';
import 'package:zob/utils/app_style.dart';

class JobScreen extends StatefulWidget {
    final int initialIndex;
     JobScreen({super.key, this.initialIndex = 0});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> with SingleTickerProviderStateMixin {
  final JobScreenController jobScreenController = Get.put(JobScreenController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: widget.initialIndex);
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Job"),
          titleTextStyle: AppStyle()
              .workSansSemiBold(context)
              .copyWith(fontSize: 20, color: AppColor.color4551),
          bottom: TabBar(
            controller: _tabController,
            labelStyle: AppStyle()
                .workSansMedium(context)
                .copyWith(fontSize: 16, color: AppColor.color4551),
            labelColor: AppColor.color8EE9,
            isScrollable: true,
            indicatorColor: AppColor.color8EE9,
            tabs: const [
              Tab(text: 'Applied Job'),
              Tab(text: 'Favourite Job'),
              Tab(text: 'Upcoming Job'),
              Tab(text: 'Saved Job'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children:  [
            // Content for Applied Job tab
            ApplyJobListWidget(jobScreenController: jobScreenController,),

            // Content for Favourite Job tab
            Center(child: Text('No Record Found')),

            // Content for Upcoming Job tab
            Center(child: Text('No Record Found')),

            // Content for Saved Job tab
            SaveJobListWidget(jobScreenController: jobScreenController,),
          ],
        ),
      ),
    );
  }
}


//// Save Job List Widget
class SaveJobListWidget extends StatefulWidget {
  JobScreenController jobScreenController;
   SaveJobListWidget({
    super.key,
    required this.jobScreenController
  });

  @override
  State<SaveJobListWidget> createState() => _SaveJobListWidgetState();
}

class _SaveJobListWidgetState extends State<SaveJobListWidget> {
  @override
  void initState() {
    super.initState();
    widget.jobScreenController.getSaveJobList();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return  Obx(()=>
         widget.jobScreenController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(color: AppColor.color8EE9),
              )
            : widget.jobScreenController.jobList.isEmpty
                ? const Center(
                    child: Text(
                      "No Reord Found",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColor.color8EE9),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: widget.jobScreenController.jobList.length,
                    itemBuilder: (context, index) {
                      var data = widget.jobScreenController.jobList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: InkWell(
                          onTap: (){
                            Get.to(JobDetailScreen(jobSlug: data.slug.toString(), jobID: data.id.toString(), isSavedScreen: false,));
                          },
                          child: Container(
                            width: width,
                            // height: height * 0.26,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.colorB3FF.withOpacity(0.3),
                                  spreadRadius: 0.5,
                                  blurRadius: 10,
                                  offset: const Offset(0.5, 0.5),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      data.logo != '' ?
                                      Container(
                                        height: height * 0.065,
                                        width: height * 0.065,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColor.color77DC
                                                  .withOpacity(0.2),
                                              spreadRadius: 0.5,
                                              blurRadius: 20,
                                              offset: const Offset(0.2, 0.2),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: data.logo ?? '',
                                            imageBuilder: (context, imageProvider) => Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                    colorFilter:
                                                        const ColorFilter.mode(AppColor.colorB3FF, BlendMode.colorBurn)),
                                              ),
                                            ),
                                            placeholder: (context, url) => CircularProgressIndicator(color: AppColor.color77DC,),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                        ),
                                      ):
                                      Container(
                                        height: height * 0.065,
                                        width: height * 0.065,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColor.color77DC
                                                  .withOpacity(0.2),
                                              spreadRadius: 0.5,
                                              blurRadius: 20,
                                              offset: const Offset(0.2, 0.2),
                                            ),
                                          ],
                                          image: 
                                           const DecorationImage(
                                            image: AssetImage(AppImg.aaplogo),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: width * 0.68,
                                            child: Text(
                                              data.jobTitle ?? '',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          SizedBox(
                                            width: width * 0.68,
                                            child: Text(
                                              data.priceFrom == '' ? (data.payTypeRequired ?? '') : "\$${data.priceFrom ?? ''} - \$${data.priceTo ?? ''}/ ${data.payTypeRequired ?? ''}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: AppColor.color77DC,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                           const SizedBox(height: 5),
                                          SizedBox(
                                            width: width * 0.68,
                                            child: Text(
                                              "Created At : ${DateFormat("dd, MMM yy HH:mma").format(data.createdAt ?? DateTime.now())}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600, color: AppColor.color77DC),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                   Row(
                                    children: [
                                      Text(
                                        "No of Vacancy: ${data.noOfWorkers == '' ? '0' : data.noOfWorkers}",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.color77DC),
                                      ),
                                      const Spacer(),
                                      const Text(
                                        "Browse Job",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 0, 52, 108)),
                                      ),
                                    ],
                                  ),
                                  /* const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width: MediaQuery.of(context).size.width *
                                            0.33,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 80, 171, 83),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: const Center(
                                            child: Text(
                                          'Casual',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )),
                                      ),
                                      const Spacer(),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width: MediaQuery.of(context).size.width *
                                            0.33,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(255, 23, 112, 26),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: const Row(
                                          children: [
                                            Spacer(),
                                            Icon(
                                              Icons.share,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Share',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      
                                         Container(
                                           height:
                                               MediaQuery.of(context).size.height *
                                                   0.05,
                                           width:
                                               MediaQuery.of(context).size.height *
                                                   0.05,
                                           decoration: BoxDecoration(
                                             color: Color.fromARGB(255, 229, 229, 229),
                                             borderRadius: BorderRadius.circular(5),
                                           ),
                                           child: Center(
                                             child: SvgPicture.asset(
                                               AppImg.saveIcon,
                                               color: AppColor.color2982,
                                             ),
                                           ),
                                         ),
                                      
                                    ],
                                  ), */
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }));
  }
}


//// Apply Job List Widget
class ApplyJobListWidget extends StatefulWidget {
  JobScreenController jobScreenController;
   ApplyJobListWidget({
    super.key,
    required this.jobScreenController
  });

  @override
  State<ApplyJobListWidget> createState() => _ApplyJobListWidgetState();
}

class _ApplyJobListWidgetState extends State<ApplyJobListWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.jobScreenController.getApplyList();
    });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return  Obx(()=>
         widget.jobScreenController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(color: AppColor.color8EE9),
              )
            : widget.jobScreenController.jobApplyList.isEmpty
                ? const Center(
                    child: Text(
                      "No Reord Found",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColor.color8EE9),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: widget.jobScreenController.jobApplyList.length,
                    itemBuilder: (context, index) {
                      var data = widget.jobScreenController.jobApplyList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: InkWell(
                          onTap: (){
                            Get.to(JobDetailScreen(jobSlug: data.slug.toString(), jobID: data.id.toString(), isSavedScreen: false,));
                          },
                          child: Container(
                            width: width,
                            // height: height * 0.26,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.colorB3FF.withOpacity(0.3),
                                  spreadRadius: 0.5,
                                  blurRadius: 10,
                                  offset: const Offset(0.5, 0.5),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      data.logo != '' ?
                                      Container(
                                        height: height * 0.065,
                                        width: height * 0.065,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColor.color77DC
                                                  .withOpacity(0.2),
                                              spreadRadius: 0.5,
                                              blurRadius: 20,
                                              offset: const Offset(0.2, 0.2),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: data.logo ?? '',
                                            imageBuilder: (context, imageProvider) => Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                    colorFilter:
                                                        const ColorFilter.mode(AppColor.colorB3FF, BlendMode.colorBurn)),
                                              ),
                                            ),
                                            placeholder: (context, url) => CircularProgressIndicator(color: AppColor.color77DC,),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                        ),
                                      ):
                                      Container(
                                        height: height * 0.065,
                                        width: height * 0.065,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColor.color77DC
                                                  .withOpacity(0.2),
                                              spreadRadius: 0.5,
                                              blurRadius: 20,
                                              offset: const Offset(0.2, 0.2),
                                            ),
                                          ],
                                          image: 
                                           const DecorationImage(
                                            image: AssetImage(AppImg.aaplogo),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: width * 0.68,
                                            child: Text(
                                              data.jobTitle ?? '',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          SizedBox(
                                            width: width * 0.68,
                                            child: Text(
                                              data.priceFrom == '' ? (data.payTypeRequired ?? '') : "\$${data.priceFrom ?? ''} - \$${data.priceTo ?? ''}/ ${data.payTypeRequired ?? ''}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: AppColor.color77DC,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                           const SizedBox(height: 5),
                                          SizedBox(
                                            width: width * 0.68,
                                            child: Text(
                                              "Created At : ${DateFormat("dd, MMM yy HH:mma").format(data.createdAt ?? DateTime.now())}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600, color: AppColor.color77DC),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                   Row(
                                    children: [
                                      Text(
                                        "No of Vacancy: ${data.noOfWorkers == '' ? '0' : data.noOfWorkers}",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.color77DC),
                                      ),
                                      const Spacer(),
                                      const Text(
                                        "Browse Job",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 0, 52, 108)),
                                      ),
                                    ],
                                  ),
                                  /* const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width: MediaQuery.of(context).size.width *
                                            0.33,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 80, 171, 83),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: const Center(
                                            child: Text(
                                          'Casual',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )),
                                      ),
                                      const Spacer(),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width: MediaQuery.of(context).size.width *
                                            0.33,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(255, 23, 112, 26),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: const Row(
                                          children: [
                                            Spacer(),
                                            Icon(
                                              Icons.share,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Share',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      
                                         Container(
                                           height:
                                               MediaQuery.of(context).size.height *
                                                   0.05,
                                           width:
                                               MediaQuery.of(context).size.height *
                                                   0.05,
                                           decoration: BoxDecoration(
                                             color: Color.fromARGB(255, 229, 229, 229),
                                             borderRadius: BorderRadius.circular(5),
                                           ),
                                           child: Center(
                                             child: SvgPicture.asset(
                                               AppImg.saveIcon,
                                               color: AppColor.color2982,
                                             ),
                                           ),
                                         ),
                                      
                                    ],
                                  ), */
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }));
  }
}
