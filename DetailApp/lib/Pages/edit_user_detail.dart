import 'dart:convert';

import 'package:DetailApp/Pages/user_page.dart';
import 'package:DetailApp/widgets/error_notifications.dart';
import 'package:DetailApp/model/user_data_api.dart';
import 'package:DetailApp/widgets/button.dart';
import 'package:DetailApp/widgets/text_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditUserData extends StatefulWidget {
  static String routeName = "/edit_user_data";
  @override
  _EditUserDataState createState() => _EditUserDataState();
}

class _EditUserDataState extends State<EditUserData> {
  UserModel _user;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController hobbyController = TextEditingController();
  final TextEditingController interestController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String firstName;
  String lastName;
  String address;
  String designation;
  String hobby;
  String interest;
  File _image;
  bool isLoading = false;

  final List<String> errors = [];

  void openGallery() async {
    var file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = file;
    });
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  void initState() {
    super.initState();
  }

  changeLoadingState() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.18),
                    Center(
                      child: Text(
                        "Almost done!",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "Fill this form to complete your registration",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    PlainTextField(
                      controller: firstNameController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          removeError(error: kNameNullError);
                        }
                        firstName = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          addError(error: kNameNullError);
                          return "";
                        }
                        return null;
                      },
                      onSaved: (newValue) => firstName = newValue,
                      label: 'First Name',
                      hint: 'Enter your first name',
                    ),
                    PlainTextField(
                      controller: lastNameController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          removeError(error: kNameNullError);
                        }
                        lastName = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          addError(error: kNameNullError);
                          return "";
                        }
                        return null;
                      },
                      onSaved: (newValue) => lastName = newValue,
                      label: 'Last Name',
                      hint: 'Enter your last name',
                    ),
                    PlainTextField(
                      controller: addressController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          removeError(error: kUserNullError);
                        }
                        address = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          addError(error: kUserNullError);
                          return "";
                        }
                        return null;
                      },
                      onSaved: (newValue) => address = newValue,
                      label: 'Address',
                      hint: 'Enter your Address',
                    ),
                    PlainTextField(
                      controller: designationController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          removeError(error: kUserNullError);
                        }
                        designation = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          addError(error: kUserNullError);
                          return "";
                        }
                        return null;
                      },
                      onSaved: (newValue) => designation = newValue,
                      label: 'Designation',
                      hint: 'Enter your designation',
                    ),
                    PlainTextField(
                      controller: hobbyController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          removeError(error: kUserNullError);
                        }
                        hobby = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          addError(error: kUserNullError);
                          return "";
                        }
                        return null;
                      },
                      onSaved: (newValue) => hobby = newValue,
                      label: 'Hobby',
                      hint: 'Enter your hobby',
                    ),
                    PlainTextField(
                      controller: interestController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          removeError(error: kUserNullError);
                        }
                        interest = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          addError(error: kUserNullError);
                          return "";
                        }
                        return null;
                      },
                      onSaved: (newValue) => interest = newValue,
                      label: 'Interest',
                      hint: 'Enter your interest',
                    ),
                    SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        openGallery();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.41,
                        height: MediaQuery.of(context).size.height * 0.21,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2.0),
                        ),
                        child: _image == null
                            ? Center(child: Text('Awaiting Image upload'))
                            : Image.file(
                                _image,
                                fit: BoxFit.contain,
                              ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _user == null
                        ? Container()
                        : CupertinoDialogAction(
                            child:
                                Text('${_user.firstName} Added Successfully'),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, UserDataPage.routeName);
                            },
                          ),
                    SizedBox(height: 50),
                    DefaultButton(
                      title: 'Register',
                      onPressed: () async {
                        final String firstName = firstNameController.text;
                        final String lastName = lastNameController.text;
                        final String address = addressController.text;
                        final String designation = designationController.text;
                        final String hobby = hobbyController.text;
                        final String interest = interestController.text;

                        final UserModel user = await addUser(firstName,
                            lastName, address, designation, hobby, interest);
                        setState(() {
                          _user = user;
                        });
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          Navigator.pushReplacementNamed(
                              context, UserDataPage.routeName);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<UserModel> addUser(
    String firstName,
    String lastName,
    String address,
    String designation,
    String hobby,
    String interest,
  ) async {
    const url = 'https://detailapp-c43f7.firebaseio.com/user.json';
    final response = await http.post(url,
        body: json.encode({
          'firstName': firstName,
          'lastName': lastName,
          'address': address,
          'designation': designation,
          'hobby': hobby,
          'interest': interest,
        }));
    if (response.statusCode == 201) {
      final String responseString = response.body;

      return userModelFromJson(responseString);
    } else {
      return null;
    }
  }
}

// Future<UserModel> addUser(
//   String firstName,
//   String lastName,
//   String address,
//   String designation,
//   String hobby,
//   String interest,
// ) async {
//   const url = 'https://detailapp-c43f7.firebaseio.com/user.json';
//   try {
//     final response = await http.post(url, body: {
//       'firstName': firstName,
//       'lastName': lastName,
//       'address': address,
//       'designation': designation,
//       'hobby': hobby,
//       'interest': interest,
//     });
//     if (response.statusCode == 201) {
//       final String responseString = response.body;
//
//       return userModelFromJson(responseString);
//     } else {
//       return null;
//     }
//   } catch (e) {
//     print(e);
//     throw (e);
//   }
// }
