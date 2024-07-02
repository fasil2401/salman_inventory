import 'package:auto_size_text/auto_size_text.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/connection_setting_controller.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/login_controller.dart';
import 'package:axolon_inventory_manager/utils/Routes/route_manger.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/constants/snackbar.dart';
import 'package:axolon_inventory_manager/utils/default_settings.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:axolon_inventory_manager/view/Connection%20Screen/connection_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final connectionSettingController = Get.put(ConnectionSettingController());

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              commonBlueColor,
              secondary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          children: [
            /// Login & Welcome back
            Container(
              height: height * 0.2,
              padding: const EdgeInsets.only(left: 10, bottom: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  /// LOGIN TEXT
                  Text('Login',
                      style: TextStyle(color: Colors.white, fontSize: 24)),
                  SizedBox(height: 3.5),

                  /// WELCOME
                  Text('Welcome Back',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: ListView(
                      // physics: const NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(height: height * 0.02),

                        Center(
                          child: SizedBox(
                            width: width * 0.35,
                            child: Image.asset('assets/images/axolon_logo.png',
                                fit: BoxFit.contain),
                          ),
                        ),
                        SizedBox(height: height * 0.05),

                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          // height: 120,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    blurRadius: 20,
                                    spreadRadius: 10,
                                    offset: const Offset(0, 10)),
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(height: height * 0.01),
                              TextField(
                                controller: loginController.userName.value,
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  border: InputBorder.none,
                                  label: Text(
                                    'User Name',
                                    style: TextStyle(
                                      color: commonBlueColor,
                                    ),
                                  ),
                                  isCollapsed: false,
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Divider(color: AppColors.lightGrey, height: 0.3),
                              SizedBox(height: height * 0.01),
                              Obx(
                                () => TextField(
                                  controller: loginController.password.value,
                                  obscureText: loginController.status.value,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none,
                                    label: Text(
                                      'Password',
                                      style: TextStyle(
                                        color: commonBlueColor,
                                      ),
                                    ),
                                    isCollapsed: false,
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    suffix: InkWell(
                                      onTap: () {
                                        loginController.check();
                                      },
                                      child: Container(
                                        width: 50,
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 4),
                                          child: SvgPicture.asset(
                                            loginController.icon.value,
                                            height:
                                                loginController.status.value ==
                                                        true
                                                    ? 10
                                                    : 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            loginController.rememberPassword();
                          },
                          splashColor: lightGrey,
                          splashFactory: InkRipple.splashFactory,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    color: mutedColor,
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Obx(() => Icon(
                                        Icons.check,
                                        size: 15,
                                        color: loginController.isRemember.value
                                            ? commonBlueColor
                                            : Colors.transparent,
                                      )),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              AutoSizeText(
                                'Remember me',
                                minFontSize: 16,
                                maxFontSize: 20,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: mutedColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Obx(
                            () => ElevatedButton(
                              onPressed: () async {
                                await loginController.validateForm();
                                await UserSimplePreferences.setRememberPassword(
                                    loginController.isRemember.value);
                                bool response =
                                    await loginController.getToken();
                                response
                                    ? UserSimplePreferences.setLogin('true')
                                    : UserSimplePreferences.setLogin('false');
                                response
                                    ? Get.offAllNamed(RouteManager.homeScreen)
                                    : SnackbarServices.errorSnackbar(
                                        loginController.message.value);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: commonBlueColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10), // <-- Radius
                                ),
                              ),
                              child: loginController.isLoading.value == true
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
                                      ),
                                    )
                                  : Text('Login',
                                      style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       Get.to(() => PaymentCollectionScreen());
                        //     },
                        //     child: Text('Payment Collection')),
                        // SizedBox(
                        //   height: 40,
                        // )
                      ],
                    ),
                  ),
                  if (!DefaultSettings.isConnectionDisabled)
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Connection Settings',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, color: mutedColor),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              Get.to(() => ConnectionScreen());
                            },
                            elevation: 2,
                            backgroundColor: commonBlueColor,
                            child: Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
