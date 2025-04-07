import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controller/login_controller/login_controller.dart';
import '../../model/user_model.dart';
import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/font_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../../shared/widgets/my_text_field.dart';
import 'job_details.dart';
import 'see_all_screen.dart';
import 'setting_screen.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  final _searchController = TextEditingController();
  final _pageController = PageController();
  final _loginController=Get.find<LoginController>(tag: 'login_controller');

  int _currentPage = 0;

  void _onStart() {
    Future.delayed(const Duration(seconds: 4), _onFinish);
  }

  void _onFinish() {
    if (_currentPage == 2) {
      setState(() {
        _currentPage = 0;
      });
    } else {
      setState(() {
        ++_currentPage;
      });
    }
    _pageController.animateToPage(_currentPage,
        duration: _currentPage == 0
            ? const Duration(milliseconds: 200)
            : const Duration(seconds: 3),
        curve: Curves.easeInOut);
    _onStart();
  }

  @override
  void initState() {
    _onStart();
    Future.delayed(Duration.zero,()async{
      await _loginController.getAllJobs();
    });
    super.initState();
  }
  @override
  void dispose() {
   _onFinish();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=>LoadingOverlay(isLoading: _loginController.isLoading, child: Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.all(PaddingManger.kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: PaddingManger.kPadding,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Hello, ${_loginController.userModel?.status==0?_loginController.userModel?.userName:_loginController.userModel?.companyOwnerName}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: getMyMediumTextStyle(color: Colors.black),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=>const SettingScreen(),transition: Transition.rightToLeft,curve: Curves.linear,duration:const Duration(milliseconds: 500));
                    },
                    child: Container(
                        padding: const EdgeInsetsDirectional.all(
                            PaddingManger.kPadding / 2),
                        decoration: BoxDecoration(
                            color: ColorManger.kPrimary,
                            borderRadius: BorderRadiusDirectional.circular(
                                PaddingManger.kPadding / 2)),
                        child: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
              if(_loginController.userModel?.status==2)
                Text(
                  'Company : ${_loginController.userModel?.companyName}',
                  style: getMyMediumTextStyle(color: ColorManger.grey),
                ),
              GestureDetector(
                onTap: (){
                  Get.to(()=>const SeeAllScreen(isForAds: false,));
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding:const EdgeInsetsDirectional.all( PaddingManger.kPadding),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(PaddingManger.kPadding),
                      color: ColorManger.grey2
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child:const Row(
                    spacing: PaddingManger.kPadding/2,
                    children: [
                      Icon(Icons.search,color: ColorManger.kPrimary,),
                      Text(
                        'Search',
                      )
                    ],
                  ),
                ),
              ),

              if(_loginController.userModel?.status==0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Lets find your perfect job....',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: getMyMediumTextStyle(color: ColorManger.grey),
                      ),
                    ),
                    TextButton(onPressed: (){
                      Get.to(()=>const SeeAllScreen(isForAds: true));
                    }, child: Text('See All Ads',style: getMyRegulerTextStyle(color: ColorManger.kPrimary),))

                  ],
                ),
              GestureDetector(
                onTap: (){
                  Get.to(()=>const SeeAllScreen(isForAds: true));
                },
                child: SizedBox(
                  height: 180,
                  width: double.maxFinite,
                  child: PageView(
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    controller: _pageController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://www.thriveinspi.org/Resources/2e99415a-01f9-4a68-bfc0-6f2e9fda835f/Find-A%20Job.png'),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadiusDirectional.circular(10)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3m_vseZtPsogrvKKGIShD_0Fjd0ge2IcFq2BGHgJwfEL6lXNgi277he1V263Dv81xQhA&usqp=CAU'),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadiusDirectional.circular(10)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://www.logitrain.com.au/wp-content/uploads/2017/07/find-a-job-computer-key-showing-work-and-careers-search-online_zyJSeQvu-1000x563.jpg'),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadiusDirectional.circular(10)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    axisDirection: Axis.horizontal,
                    effect: SlideEffect(
                        spacing: 8.0,
                        radius: 6.0,
                        dotWidth: 20.0,
                        dotHeight: 15.0,
                        paintStyle: PaintingStyle.stroke,
                        strokeWidth: 2,
                        dotColor: ColorManger.grey2,
                        activeDotColor: ColorManger.kPrimary),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if(_loginController.userModel?.status==0)
                    Text(
                      'Job Recommendation',
                      style: getMyMediumTextStyle(color: Colors.black),
                    ),
                  if(_loginController.userModel?.status==2)
                    Text(
                      'Your Job Ads',
                      style: getMyMediumTextStyle(color: Colors.black),
                    ),
                  TextButton(
                      onPressed: () {
                        Get.to(()=>const SeeAllScreen(isForAds: false,),transition: Transition.rightToLeft,curve: Curves.linear,duration:const Duration(milliseconds: 500));
                      },
                      child: Text(
                        'See All',
                        style:
                        getMyMediumTextStyle(color: ColorManger.kPrimary),
                      )),
                ],
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics:const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index)=>buildWorkItem(_loginController.allJons[index]),
                  separatorBuilder: (context,index)=>const SizedBox(
                    height: PaddingManger.kPadding/2,
                  ),
                  itemCount: _loginController.allJons.length)
            ],
          ),
        ),
      ),
    ),progressIndicator:const  CircularProgressIndicator(color: ColorManger.kPrimary,),));
  }

  Widget buildWorkItem(JobModel model) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: (){
      if(_loginController.userModel?.status==0){
        Get.to(()=> JobDetails(model: model,),transition: Transition.rightToLeft,curve: Curves.linear,duration:const Duration(milliseconds: 500));
      }
    },
    child: Container(
          padding: const EdgeInsetsDirectional.all(10),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadiusDirectional.circular(PaddingManger.kPadding / 2),
              color: ColorManger.grey.withOpacity(0.1)),
          child: Row(
            children: [
              Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(
                          PaddingManger.kPadding / 2)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.network(
                      model.jobImage??'',fit: BoxFit.cover,)),
              const SizedBox(
                width: PaddingManger.kPadding / 3,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.companyName.toUpperCase(),
                      style: getMyMediumTextStyle(
                          color: Colors.black,),
                    ),
                    Text(
                    model.jobName?.toUpperCase()??'',
                      style: getMyRegulerTextStyle(
                          color: ColorManger.grey, fontSize: FontSize.s12),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
  );
}


