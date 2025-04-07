import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../controller/login_controller/login_controller.dart';
import 'contact_us_mesages.dart';
import 'user_and_company_details_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  final _loginController=Get.find<LoginController>(tag: 'login_controller');


  @override
  void initState() {
   Future.delayed(Duration.zero,()async{
     await _loginController.getAllUsersCompaniesAdmin();
   });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Obx(()=>LoadingOverlay(isLoading: _loginController.isLoading, child: Scaffold(
      appBar: AppBar(
        title:const Text(
          'Admin Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Text
            const  Padding(
              padding:  EdgeInsets.only(bottom: 20),
              child: Text(
                'Welcome, Admin!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildActionCard(
                    context,
                    'Create Company Account',
                    Icons.business,
                        () {
                      print('Navigate to Create Company Page');
                    },
                  ),
                ),
                Expanded(
                  child: _buildActionCard(
                    context,
                    'Messages & Contact Us',
                    Icons.view_list,
                        () {
                      Get.to(()=>const ContactUsMessages());


                    },
                  ),
                ),
              ],
            ),

            const  SizedBox(height: 40),

            _buildSectionTitle('All Users'),

            _buildUserList(),

            const  SizedBox(height: 20),

            _buildSectionTitle('All Companies'),

            _buildCompanyList(),
          ],
        ),
      ),
    )));
  }

  Widget _buildActionCard(
      BuildContext context,
      String title,
      IconData icon,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.blueAccent,
        child: Container(
          padding: const EdgeInsets.all(20),

          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: Colors.white, size: 40),
                const SizedBox(height: 10),
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style:const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style:const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _buildUserList() {

    return ListView.builder(
      shrinkWrap: true,
      physics:const NeverScrollableScrollPhysics(),
      itemCount: _loginController.allUsersAdmin.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            Get.to(()=>UserAndCompanyDetailsScreen(userModel: _loginController.allUsersAdmin[index]));
          },
          child: Card(
            elevation: 3,
            margin:const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(
                _loginController.allUsersAdmin[index].userName??'',
                style:const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Email: ${_loginController.allUsersAdmin[index].email}'),
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                backgroundImage: NetworkImage(_loginController.allUsersAdmin[index].profileImage??''),
              ),
              trailing:const Icon(Icons.arrow_forward_ios),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCompanyList() {

    return ListView.builder(
      shrinkWrap: true,
      physics:const NeverScrollableScrollPhysics(),
      itemCount: _loginController.allCompaniesAdmin.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            Get.to(()=>UserAndCompanyDetailsScreen(userModel: _loginController.allCompaniesAdmin[index]));

          },
          child: Card(
            elevation: 3,
            margin:const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(
                _loginController.allCompaniesAdmin[index].companyName??'',
                style:const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Industry: ${_loginController.allCompaniesAdmin[index].industry}'),
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                backgroundImage: NetworkImage(_loginController.allCompaniesAdmin[index].profileImage??''),
              ),
              trailing:const Icon(Icons.arrow_forward_ios),
            ),
          ),
        );
      },
    );
  }


}
