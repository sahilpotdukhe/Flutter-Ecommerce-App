import 'dart:io';
import 'package:d_mart/Pages/Loading.dart';
import 'package:d_mart/Pages/StartPage.dart';
import 'package:d_mart/provider/appProvider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_mart/Services/UserServices.dart';
import 'package:d_mart/provider/userprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

enum Page { Accountinfo, editinfo }

class AccountInfo extends StatefulWidget {
  const AccountInfo({Key key}) : super(key: key);

  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  Page _selectedpage = Page.Accountinfo;
  GlobalKey<FormState> _formKey = GlobalKey();
  UserService _userService = UserService();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  PickedFile _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FlatButton(
          child: Text(
            'Profile',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          onPressed: () {
            setState(() {
              _selectedpage = Page.Accountinfo;
            });
          },
        ),
        centerTitle: true,
        backgroundColor: HexColor('#d91f2a'),
        actions: [
          FlatButton.icon(
            label: Text('Edit',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                )),
            icon: Icon(Icons.edit),
            onPressed: () {
              setState(() {
                _selectedpage = Page.editinfo;
              });
            },
          )
        ],
      ),
      body: _loadScreen(),
    );
  }

  Widget _loadScreen() {
    switch (_selectedpage) {
      case Page.Accountinfo:
        final userProvider = Provider.of<UserProvider>(context);
        return Scaffold(
          body: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(
                        userProvider.userModel.image ??
                            'https://stratosphere.co.in/img/user.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  decoration: new BoxDecoration(
                    // border color
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 5.0,
                      color: HexColor('#6f6434'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                  child: Text(
                userProvider.userModel.name ?? '',
                style: TextStyle(fontSize: 22),
              )),
              Center(
                  child: Text(
                userProvider.userModel.email ?? '',
                style: TextStyle(fontSize: 14),
              )),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        userProvider.userModel.name,
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 33,
                      ),
                      Text(
                        'Email ID',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Text(
                            userProvider.userModel.email,
                            style: TextStyle(fontSize: 14),
                          ),
                          Expanded(
                              child: SizedBox(
                            width: 60,
                          )),
                          Text(
                            'Verify Email   ',
                            style: TextStyle(
                              color: HexColor('#d91f2a'),
                            ),
                          ),
                          Icon(
                            Icons.check_circle_rounded,
                            color: Colors.green,
                            size: 16,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 33,
                      ),
                      Text(
                        'Phone Number',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      SelectableText(
                        userProvider.userModel.phone ?? '',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 33,
                      ),
                      Text(
                        'Address',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      SelectableText(
                        //It makes text selected and one can copy also
                        userProvider.userModel.address ?? '',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 33,
                      ),
                      Text(
                        'User ID',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      SelectableText(
                        //It makes text selected and one can copy also
                        userProvider.userModel.uid,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Center(
                child: RaisedButton(
                  onPressed: () {
                    userProvider.signOutme();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>StartPage()));
                  },
                  color: HexColor('#d91f2a'),
                  child: Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        );
        break;

      case Page.editinfo:
        final userProvider = Provider.of<UserProvider>(context);
        final appProvider = Provider.of<AppProvider>(context);
        TextEditingController namecontroller =
            TextEditingController(text: userProvider.userModel.name);
        TextEditingController emailcontroller =
            TextEditingController(text: userProvider.userModel.email);
        TextEditingController phonecontroller =
            TextEditingController(text: userProvider.userModel.phone);
        TextEditingController addresscontroller =
            TextEditingController(text: userProvider.userModel.address);
        return Scaffold(
          body: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: InkWell(
                  onTap: () {
                    final _picker = ImagePicker();
                    _selectImage(_picker.getImage(source: ImageSource.gallery));
                  },
                  child: Stack(
                    children: [
                      Container(
                        child: CircleAvatar(
                          radius: 50.0,
                          child: ClipRRect(
                            child: _displayChild(),
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        decoration: new BoxDecoration(
                          // border color
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 5.0,
                            color: HexColor('#6f6434'),
                          ),
                        ),
                      ),
                      Positioned(
                        height: 38,
                        width: 96,
                        left: 6,
                        bottom: 4,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50))),
                            child: Center(
                                child: Text(
                              'Edit',
                              style: TextStyle(color: Colors.white),
                            ))),
                      )
                    ],
                  ),
                )),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Please enter Your Full Name',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 20,
                          child: TextFormField(
                            controller: namecontroller,
                            //initialValue: userProvider.userModel.name,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter Name';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 33,
                        ),
                        Text(
                          'Please enter your Email ID',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 20,
                          child: TextFormField(
                            controller: emailcontroller,
                            //initialValue: userProvider.userModel.email,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter email address';
                              }
                              if (!RegExp(
                                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?"
                                      r"(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                  .hasMatch(value)) {
                                return 'Please enter a valid email Address';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 33,
                        ),
                        Text(
                          'Please enter your Phone Number',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 40,
                          child: TextFormField(
                            controller: phonecontroller,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter Phone No';
                              } else if (value.length < 10) {
                                return 'Enter 10 digit Phone number';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 33,
                        ),
                        Text(
                          'Please enter your Address',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        TextFormField(
                          controller: addresscontroller,
                          keyboardType: TextInputType.multiline,
                          maxLines: 2,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter Address';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Center(
                  child: appProvider.isLoading
                      ? Loading()
                      : RaisedButton(
                          color: HexColor('#d91f2a'),
                          child: Text(
                            'Save Changes',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              appProvider.changeIsLoading();
                              if (_image != null) {
                                String imageurl;
                                final FirebaseStorage storage = FirebaseStorage.instance;
                                final picture = '1${DateTime.now().microsecondsSinceEpoch.toString()}.jpg';
                                final File _imagep = File(_image.path);
                                UploadTask task = storage.ref().child(picture).putFile(_imagep);
                                TaskSnapshot snapshot = (await task.whenComplete(() => task.snapshot));
                                await task.whenComplete(() async {
                                  imageurl = await snapshot.ref.getDownloadURL();
                                });
                                String image = imageurl;
                                _firestore
                                    .collection('eusers')
                                    .doc(userProvider.userModel.uid)
                                    .update({
                                  'name': namecontroller.text,
                                  'email': emailcontroller.text,
                                  'phone': phonecontroller.text,
                                  'address': addresscontroller.text,
                                  'image': image,
                                });
                                userProvider.reloadUserModel();
                                appProvider.changeIsLoading();
                                Fluttertoast.showToast(msg: 'Changes Saved');
                                setState(() {
                                  _selectedpage = Page.Accountinfo;
                                });
                              } else {
                                appProvider.changeIsLoading();
                                Fluttertoast.showToast(
                                    msg: 'Profile image must be provided');
                              }
                            }
                          },
                        ),
                )
              ],
            ),
          ),
        );
    }
  }

  void _selectImage(Future<PickedFile> image) async {
    PickedFile tempImage = await image;
    setState(() {
      _image = tempImage;
    });
  }

  Widget _displayChild() {
    final userProvider = Provider.of<UserProvider>(context);
    if (_image == null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: CircleAvatar(
          radius: 50.0,
          backgroundImage: NetworkImage(userProvider.userModel.image),
        ),
      );
    } else {
      final File _imagex = File(_image.path);
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: CircleAvatar(
          radius: 50.0,
          backgroundImage: FileImage(_imagex),
        ),
      );
    }
  }
}
