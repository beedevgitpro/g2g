import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g2g/components/navigationDrawer.dart';
import 'package:g2g/components/progressDialog.dart';
import 'package:g2g/constants.dart';
import 'package:g2g/controllers/accountsController.dart';
import 'package:g2g/controllers/clientController.dart';
import 'package:g2g/controllers/resetController.dart';
import 'package:g2g/controllers/updatePasswordController.dart';
import 'package:g2g/models/updatePasswordModel.dart';
import 'package:g2g/responsive_ui.dart';
import 'package:g2g/screens/homeScreen.dart';
import 'package:g2g/screens/loginScreen.dart';
import 'package:g2g/screens/splashScreen.dart';
import 'package:g2g/utility/hashSha256.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdatePassword extends StatefulWidget {
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword>
    with SingleTickerProviderStateMixin {
  final _updatePasswordScaffoldKey = GlobalKey<ScaffoldState>();

  final _updatePasswordFormKey = GlobalKey<FormState>();
  final userID = TextEditingController();
  final emailID = TextEditingController();
  final mobileNumber = TextEditingController();
  final password = TextEditingController();
  final updatePasswordController = UpdatePasswordController();

  bool _autoValidate = false;
  AnimationController animationController;
  Animation animation;
  final userIDNode = FocusNode();
  final emailIDNode = FocusNode();
  final mobileNode = FocusNode();
  final pwdNode = FocusNode();
  double _height;
  double _width;
  double _pixelRatio;
  bool _isLarge;
  bool _loading = false;

  @override
  void initState() {
    super.initState();

    tripleDES();
    // animationController =
    //     AnimationController(vsync: this, duration: Duration(seconds: 1));
    // animation =
    //     CurvedAnimation(parent: animationController, curve: Curves.bounceIn);
    // animationController.forward();
    // animationController.addListener(() {
    //   setState(() {});
    //   // print(animationController.value);
    // });
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _width = MediaQuery.of(context).size.width;
    _isLarge = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    return Scaffold(
      drawer: NavigationDrawer(),
      key: _updatePasswordScaffoldKey,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          new Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: const AssetImage('images/bg.jpg'),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0),
            child: AppBar(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xffccebf2),
                child: IconButton(
                  onPressed: () {
                    print('abc');
                    _updatePasswordScaffoldKey.currentState.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: kSecondaryColor,
                    size: _isLarge ? 35 : 30,
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xffccebf2),
                    child: IconButton(
                      onPressed: () {
                        launch("tel://1300197727");
                      },
                      icon: Icon(
                        Icons.call,
                        color: kSecondaryColor,
                        size: _isLarge ? 35 : 30,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
          ),
          Positioned(
            top: 50.0,
            left: 0.0,
            bottom: 0.0,
            right: 0.0,
            child: SafeArea(
                child: GestureDetector(
              onPanDown: (_) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 60, bottom: 10, left: 20, right: 20.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          'images/logo2.png',
                          height: _isLarge ? 400 : 150,
                        ),
                        Text(
                          'Update Password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Form(
                            autovalidate: _autoValidate,
                            key: _updatePasswordFormKey,
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buildFormField(Icons.person_outline, userID,
                                      'UserID', userIDNode, emailIDNode),
                                  SizedBox(height: 15),
                                  buildFormField(Icons.person_outline, emailID,
                                      'Email Address', emailIDNode, mobileNode),
                                  SizedBox(height: 15),
                                  buildFormField(Icons.call, mobileNumber,
                                      'Mobile Number', mobileNode, pwdNode,
                                      obscureText: false),
                                  SizedBox(height: 10),
                                  buildFormField(Icons.lock, password,
                                      'New Password', pwdNode, null,
                                      obscureText: true),
                                  SizedBox(height: 10),
                                  Container(
                                    child: RaisedButton(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Update Password'.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: _isLarge ? 26 : 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      color: kPrimaryColor,
                                      // padding: EdgeInsets.only(
                                      //     top: 15, bottom: 15, left: 15, right: 15),
                                      onPressed: () async {
                                        if (_updatePasswordFormKey.currentState
                                            .validate()) {
                                          final pr = ProgressDialog(context,
                                              isLogin: true);
                                          setState(() {
                                            pr.show();
                                          });

                                          updatePasswordController
                                              .updatePassword(
                                                  userID.text,
                                                  emailID.text,
                                                  mobileNumber.text,
                                                  password.text)
                                              .then(
                                            (updatePassword) async {
                                              if (updatePassword
                                                      .PasswordResetSuccess ==
                                                  'FALSE') {
                                                pr.hide();
                                                Alert(
                                                    context: context,
                                                    title:
                                                        '${updatePassword.Message}',
                                                    type: AlertType.error,
                                                    buttons: [
                                                      DialogButton(
                                                        child: Text(
                                                          "Close",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: _isLarge
                                                                  ? 24
                                                                  : 18),
                                                        ),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        color: kPrimaryColor,
                                                        radius: BorderRadius
                                                            .circular(0.0),
                                                      ),
                                                    ],
                                                    style: AlertStyle(
                                                      animationType:
                                                          AnimationType.fromTop,
                                                      isCloseButton: false,
                                                      isOverlayTapDismiss:
                                                          false,
                                                      titleStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: _isLarge
                                                              ? 24
                                                              : 18),
                                                    )).show();
                                              } else {
                                                pr.hide();
                                                // Navigator.pushAndRemoveUntil(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             SplashScreen()),
                                                //     (route) => false);
                                              }
                                            },
                                          );
                                        } else {
                                          setState(() {
                                            _autoValidate = true;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget buildFormField(IconData icon, TextEditingController controller,
      String labelText, FocusNode fNode, FocusNode nextNode,
      {bool obscureText = false}) {
    return Container(
      child: TextFormField(
        cursorColor: kPrimaryColor,
        inputFormatters: obscureText ? null : [],
        validator: (value) {
          if (value.isEmpty)
            return obscureText ? 'Password Required' : 'ID Required';
          return null;
        },
        textInputAction:
            nextNode != null ? TextInputAction.next : TextInputAction.done,
        textCapitalization: obscureText
            ? TextCapitalization.sentences
            : TextCapitalization.characters,
        obscureText: obscureText,
        focusNode: fNode,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            prefixIcon:
                Icon(icon, color: kPrimaryColor, size: _isLarge ? 30 : 24),
            hintText: labelText,
            hintStyle:
                TextStyle(fontSize: _isLarge ? 24 : 18, color: Colors.black54)),
        style: TextStyle(
          fontSize: _isLarge ? 24 : 18,
          color: Colors.black,
        ),
        onFieldSubmitted: (value) {
          if (nextNode != null) nextNode.requestFocus();
        },
        controller: controller,
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
