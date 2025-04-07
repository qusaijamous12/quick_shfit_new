import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart'; // Ensure you have this import
import 'package:get/get.dart';

import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/my_app_bar.dart';
import '../../shared/widgets/my_text_field.dart';
import 'add_company_owner_screen_tw.dart';

class AddCompanyOwner extends StatefulWidget {
  const AddCompanyOwner({super.key});

  @override
  _AddCompanyOwnerState createState() => _AddCompanyOwnerState();
}

class _AddCompanyOwnerState extends State<AddCompanyOwner> {
  final _companyNameController = TextEditingController();
  final _companyOwnerNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyWebSite = TextEditingController();

  // // Dropdown selection variables
  // String? _selectedIndustry;
  // String? _selectedSubCategory;
  //
  // // List of industries
  // final List<String> industries = [
  //   'Energy & Environment',
  //   'Agriculture',
  //   'Non-Profit & Social Causes',
  //   'Media & Entertainment',
  //   'Legal Services',
  //   'Logistics & Transportation',
  //   'Marketing & Advertising',
  //   'Manufacturing',
  //   'Finance',
  //   'Education',
  //   'Technology',
  // ];
  //
  // final Map<String, List<String>> subCategories = {
  //   'Technology': ['Software Development', 'Mobile Apps', 'Web Development'],
  //   'Finance': ['Banking', 'Investment', 'Accounting'],
  //   'Education': ['Online Learning', 'Tutoring', 'Schools'],
  //   'Energy & Environment': ['Renewable Energy', 'Sustainability', 'Oil & Gas'],
  //   'Agriculture': ['Farming', 'Agricultural Tech', 'Livestock'],
  //   'Non-Profit & Social Causes': ['Charity', 'Social Work', 'Environmental Causes'],
  //   'Media & Entertainment': ['Film Production', 'Music', 'Gaming'],
  //   'Legal Services': ['Law Firms', 'Consulting', 'Legal Tech'],
  //   'Logistics & Transportation': ['Freight', 'Shipping', 'Delivery Services'],
  //   'Marketing & Advertising': ['Digital Marketing', 'Branding', 'Advertising'],
  //   'Manufacturing': ['Industrial Equipment', 'Consumer Goods', 'Electronics'],
  // };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Utils.hideKeyboard(context);
      },
      onVerticalDragDown: (details){
        Utils.hideKeyboard(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(title: 'Add Company'),
        body: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: PaddingManger.kPadding,
            children: [
              Text(
                'Please fill the following fields to add a company owner ...',
                style: getMyMediumTextStyle(color: Colors.black),
              ),
              // Company Name
              Text(
                'Company Name',
                style: getMyRegulerTextStyle(color: ColorManger.grey),
              ),
              MyTextField(controller: _companyNameController, labelText: 'Name', prefixIcon: const Icon(Icons.work, color: Colors.white,)),

              // Company Owner Name
              Text(
                'Company Owner Name',
                style: getMyRegulerTextStyle(color: ColorManger.grey),
              ),
              MyTextField(controller: _companyOwnerNameController, labelText: 'Name', prefixIcon: const Icon(Icons.person, color: Colors.white,)),

              // Company Email
              Text(
                'Company Email',
                style: getMyRegulerTextStyle(color: ColorManger.grey),
              ),
              MyTextField(controller: _emailController, labelText: 'Email', prefixIcon: const Icon(Icons.email_outlined, color: Colors.white,)),

              // Password
              Text(
                'Password',
                style: getMyRegulerTextStyle(color: ColorManger.grey),
              ),
              MyTextField(controller: _passwordController, labelText: 'Enter Your Password', prefixIcon: const Icon(Icons.lock_open, color: Colors.white,), isPassword: true),

              // Mobile Number
              Text(
                'Mobile Number',
                style: getMyRegulerTextStyle(color: ColorManger.grey),
              ),
              MyTextField(controller: _phoneController, labelText: 'Enter Your Phone', prefixIcon: const Icon(Icons.phone, color: Colors.white,),keyBoardType: TextInputType.phone,),

              // Company Website
              Text(
                'If your company has a website, please add the URL in the following field',
                style: getMyRegulerTextStyle(color: ColorManger.grey),
              ),
              MyTextField(controller: _companyWebSite, labelText: 'URL', prefixIcon: const Icon(Icons.work, color: Colors.white,)),

              // Industry Dropdown
              Text(
                'Select Industry',
                style: getMyRegulerTextStyle(color: ColorManger.grey),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadiusDirectional.circular(20),
              //   ),
              //   clipBehavior: Clip.antiAliasWithSaveLayer,
              //   child: DropdownButtonFormField2<String>(
              //     value: _selectedIndustry,
              //     decoration: InputDecoration(
              //       hintText: 'Select Industry',
              //       border: InputBorder.none,
              //       filled: true,
              //       fillColor: ColorManger.grey.withOpacity(0.1),
              //     ),
              //     items: industries.map((element) {
              //       return DropdownMenuItem<String>(
              //         value: element,
              //         child: Text(
              //           element,
              //           style: getMyLightTextStyle(color: Colors.black),
              //         ),
              //       );
              //     }).toList(),
              //     onChanged: (value) {
              //       setState(() {
              //         _selectedIndustry = value;
              //         _selectedSubCategory = null; // Reset subcategory when industry changes
              //       });
              //     },
              //     buttonStyleData: const ButtonStyleData(
              //       padding: EdgeInsets.only(right: 8),
              //     ),
              //     iconStyleData: const IconStyleData(
              //       icon: Icon(
              //         Icons.arrow_drop_down,
              //         color: ColorManger.kPrimary,
              //       ),
              //       iconSize: 24,
              //     ),
              //     dropdownStyleData: DropdownStyleData(
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(15),
              //       ),
              //     ),
              //     menuItemStyleData: const MenuItemStyleData(
              //       padding: EdgeInsets.symmetric(horizontal: 16),
              //     ),
              //   ),
              // ),

              // Subcategory Dropdown (visible only if an industry is selected)
              // if (_selectedIndustry != null)
              //   Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         'Select Subcategory',
              //         style: getMyRegulerTextStyle(color: ColorManger.grey),
              //       ),
              //       const SizedBox(
              //         height: PaddingManger.kPadding,
              //       ),
              //       Container(
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadiusDirectional.circular(20),
              //         ),
              //         clipBehavior: Clip.antiAliasWithSaveLayer,
              //         child: DropdownButtonFormField2<String>(
              //           value: _selectedSubCategory,
              //           decoration: InputDecoration(
              //             hintText: 'Select Subcategory',
              //             border: InputBorder.none,
              //             filled: true,
              //             fillColor: ColorManger.grey.withOpacity(0.1),
              //           ),
              //           items: subCategories[_selectedIndustry]!
              //               .map((subCategory) {
              //             return DropdownMenuItem<String>(
              //               value: subCategory,
              //               child: Text(
              //                 subCategory,
              //                 style: getMyLightTextStyle(color: Colors.black),
              //               ),
              //             );
              //           }).toList(),
              //           onChanged: (value) {
              //             setState(() {
              //               _selectedSubCategory = value;
              //             });
              //           },
              //           buttonStyleData: const ButtonStyleData(
              //             padding: EdgeInsets.only(right: 8),
              //           ),
              //           iconStyleData: const IconStyleData(
              //             icon: Icon(
              //               Icons.arrow_drop_down,
              //               color: ColorManger.kPrimary,
              //             ),
              //             iconSize: 24,
              //           ),
              //           dropdownStyleData: DropdownStyleData(
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(15),
              //             ),
              //           ),
              //           menuItemStyleData: const MenuItemStyleData(
              //             padding: EdgeInsets.symmetric(horizontal: 16),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Move to the next page ...',
                    style: getMyRegulerTextStyle(color: ColorManger.grey),
                  ),
                  GestureDetector(
                    onTap: (){
                      if(_companyNameController.text.isNotEmpty&&_companyOwnerNameController.text.isNotEmpty&&_emailController.text.isNotEmpty&&_passwordController.text.isNotEmpty&&_phoneController.text.isNotEmpty){
                        Get.to(()=> AddCompanyOwnerScreenTwo(companyName: _companyNameController.text, companyOwnerName: _companyOwnerNameController.text, email: _emailController.text, password: _passwordController.text, mobileNumber: _phoneController.text));

                      }else{
                        Utils.myToast(title: 'All Fields are requierd');
                      }
                    },
                    child: Container(
                      padding:const EdgeInsetsDirectional.all(PaddingManger.kPadding/1.5),
                      decoration:const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorManger.kPrimary
                      ),
                      child:const Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
