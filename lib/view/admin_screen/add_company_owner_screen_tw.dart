import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../controller/login_controller/login_controller.dart';
import '../../shared/dialogs/loading_dialog.dart';
import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/my_app_bar.dart';
import '../../shared/widgets/my_button.dart';
import '../../shared/widgets/my_text_field.dart';

class AddCompanyOwnerScreenTwo extends StatefulWidget {
  final String companyName;
  final String companyOwnerName;
  final String email;
  final String password;
  final String mobileNumber;
  final String companyUrl;


  const AddCompanyOwnerScreenTwo(
      {super.key,
      required this.companyName,
      required this.companyOwnerName,
      required this.email,
      required this.password,
      required this.mobileNumber,
      this.companyUrl = '',
});

  @override
  State<AddCompanyOwnerScreenTwo> createState() =>
      _AddCompanyOwnerScreenTwoState();
}

class _AddCompanyOwnerScreenTwoState extends State<AddCompanyOwnerScreenTwo> {
  LatLng? _selectedLocation;
  GoogleMapController? _mapController;
  final _loginController = Get.find<LoginController>(tag: 'login_controller');
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() => LoadingOverlay(
          isLoading: _loginController.isLoading,
          progressIndicator:const LoadingDialog(),
          child: GestureDetector(
            onTap: (){
              Utils.hideKeyboard(context);
            },
            onVerticalDragDown: (details){
              Utils.hideKeyboard(context);
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: myAppBar(title: 'Adding Company'),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Company Description',
                      style: getMyRegulerTextStyle(color: ColorManger.grey),
                    ),
                    MyTextField(
                        controller: _descriptionController,
                        labelText: 'Description',
                        prefixIcon: const Icon(
                          Icons.description,
                          color: ColorManger.kPrimary,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Please Set The location for the Comapny in the map',
                      style: getMyRegulerTextStyle(color: ColorManger.grey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: GoogleMap(
                          initialCameraPosition: const CameraPosition(
                            target: LatLng(24.7136, 46.6753),
                            // Initial position (Riyadh)
                            zoom: 14,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _mapController =
                                controller; // Initialize the map controller
                          },
                          onTap: (LatLng location) {
                            setState(() {
                              _selectedLocation =
                                  location; // Store the tapped location
                            });
                            if (_mapController != null) {
                              // Ensure the controller is not null before using it
                              _mapController!.animateCamera(
                                CameraUpdate.newLatLng(
                                    location), // Move the camera to the tapped location
                              );
                            }
                          },
                          markers: _selectedLocation == null
                              ? {}
                              : {
                                  Marker(
                                    markerId: const MarkerId('selected_location'),
                                    position: _selectedLocation!,
                                    infoWindow: InfoWindow(
                                      title: 'Selected Location',
                                      snippet:
                                          'Lat: ${_selectedLocation!.latitude}, Lng: ${_selectedLocation!.longitude}',
                                    ),
                                  ),
                                },
                        ),
                      ),
                    ),
                    if (_selectedLocation != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Selected Location: Lat: ${_selectedLocation!.latitude}, Lng: ${_selectedLocation!.longitude}',
                          style: getMyRegulerTextStyle(color: ColorManger.grey),
                        ),
                      ),
                    const SizedBox(
                      height: 40,
                    ),
                    MyButton(
                        title: 'Add',
                        onTap: () async {
                          if (_selectedLocation?.longitude != null &&
                              _selectedLocation?.latitude != null &&
                              _descriptionController.text.isNotEmpty) {
                            await _loginController.createCompanyOwnerAccount(
                                companyName: widget.companyName,
                                companyOwnerName: widget.companyOwnerName,
                                email: widget.email,
                                password: widget.password,
                                mobileNumber: widget.mobileNumber,
                                description: _descriptionController.text,
                                latitude: _selectedLocation!.latitude,
                                longitude: _selectedLocation!.longitude);
                          } else {
                            Utils.myToast(title: 'All Fields are requierd');
                          }
                        },
                        btnColor: ColorManger.kPrimary,
                        textColor: Colors.white)
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  bool checkNull() {
    if (_selectedLocation?.latitude != null &&
        _selectedLocation?.longitude != null) {
      return true;
    } else {
      return false;
    }
  }
}
