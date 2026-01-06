import 'package:bhai_chara/common/custom_button.dart';
import 'package:bhai_chara/model/user_model.dart';
import 'package:bhai_chara/utils/app_colors.dart';
import 'package:bhai_chara/utils/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/provider/editprofileProvider/editprofileprovider.dart';


class ProfileEdit extends StatelessWidget {
  final UserModel userdata;
  const ProfileEdit({super.key, required this.userdata});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final provider = ProfileEditProvider();
        provider.initData(userdata);
        return provider;
      },
      child: Consumer<ProfileEditProvider>(
        builder: (context, provider, _) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 1,
                centerTitle: true,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.black)),
                title: const Text(
                  "Edit Profile",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              body: provider.isLoading
                  ? const Center(child: CustomLoader())
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Stack(
                                  children: [
                                    provider.profilePic == null &&
                                            userdata.image == ""
                                        ? Container(
                                            height: 140,
                                            width: 140,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/profile_photo.png"),
                                                    fit: BoxFit.cover),
                                                shape: BoxShape.circle,
                                                color: Colors.black12),
                                          )
                                        : provider.profilePic != null
                                            ? Container(
                                                height: 140,
                                                width: 140,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: FileImage(
                                                          provider.profilePic!),
                                                      fit: BoxFit.fitWidth),
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  height: 140,
                                                  width: 140,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            userdata.image!),
                                                        fit: BoxFit.fitWidth),
                                                  ),
                                                ),
                                              ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            provider.pickProfilePhoto();
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors.blue),
                                                color: Colors.white,
                                                shape: BoxShape.circle),
                                            child: const Icon(
                                              Icons.camera_alt_rounded,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 15),
                                    const Text("Full Name"),
                                    TextField(
                                      controller: provider.fullNameController,
                                      decoration: const InputDecoration(),
                                    ),
                                    const SizedBox(height: 15),
                                    const Text("Email Address"),
                                    TextField(
                                      controller: provider.emailController,
                                      decoration: const InputDecoration(),
                                    ),
                                    const SizedBox(height: 25),
                                    CustomButton(
                                      width: MediaQuery.of(context).size.width,
                                      text: "Update",
                                      onTap: () {
                                        provider.updateUserProfile(
                                            context, userdata);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}




// // ignore_for_file: use_build_context_synchronously
// import 'dart:io';
// import 'package:bhai_chara/common/custom_button.dart';
// import 'package:bhai_chara/controller/services/Firebase_Manager.dart';
// import 'package:bhai_chara/controller/services/shared_prefrences.dart';
// import 'package:bhai_chara/model/user_model.dart';
// import 'package:bhai_chara/utils/app_colors.dart';
// import 'package:bhai_chara/utils/custom_loader.dart';
// import 'package:bhai_chara/utils/showSnack.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';


// class ProfileEdit extends StatefulWidget {
//   final UserModel userdata;
//   const ProfileEdit({super.key, required this.userdata});

//   @override
//   State<ProfileEdit> createState() => _ProfileEditState();
// }

// class _ProfileEditState extends State<ProfileEdit> {
//   final SharedPreferenceHelper _sharedPreferenceHelper =
//       SharedPreferenceHelper.instance();
//   File? profilepic;
//   Future profilePhoto() async {
//     XFile? groupcover;
//     groupcover = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (groupcover != null) {
//       setState(() {
//         profilepic = File(groupcover!.path);
//       });
//       print(groupcover.path);
//     }
//   }

//   bool isloading = false; // Change this line
//   updateUserProfile(BuildContext context, String id, String name, String email,
//       File? imageFile) async {
//     try {
//       // Set isLoading to true to indicate that the update process has started
//       setState(() {
//         isloading = true;
//       });
//       Map<String, dynamic> updatedUserData =
//           await FirebaseManager.updateProfile(
//         uid: id,
//         name: name, // New name value
//         email: email, // New email value
//         profileImage: imageFile, // New profile image file
//       );
//       UserModel updatedUser = UserModel.fromJson(updatedUserData);
//       await _sharedPreferenceHelper.insertUser(updatedUser);
//       setState(() {
//         isloading = false;
//       });
//       showSnack(context: context, text: "Profile Updated Successfully");
//     } catch (e) {
//       // Handle error if any
//       print('Error updating profile: $e');
//       showSnack(context: context, text: e.toString());
//       setState(() {
//         isloading = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setState(() {
//       fullName = TextEditingController(text: widget.userdata.name!);
//       email = TextEditingController(text: widget.userdata.email!);
//     });
//   }

//   TextEditingController fullName = TextEditingController();
//   TextEditingController email = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusManager.instance.primaryFocus!.unfocus();
//       },
//       child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             elevation: 1,
//             centerTitle: true,
//             leading: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context, true);
//                 },
//                 icon: const Icon(Icons.arrow_back, color: Colors.black)),
//             title: const Text(
//               "Edit Profile",
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//           body: isloading == true
//               ? const Center(
//                   child: CustomLoader(),
//                 )
//               : Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SingleChildScrollView(
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Center(
//                             child: Stack(
//                               children: [
//                                 profilepic == null &&
//                                         widget.userdata.image == ""
//                                     ? Container(
//                                         height: 140,
//                                         width: 140,
//                                         decoration: const BoxDecoration(
//                                             image: DecorationImage(
//                                                 image: AssetImage(
//                                                     "assets/images/profile_photo.png"),
//                                                 fit: BoxFit.cover),
//                                             shape: BoxShape.circle,
//                                             color: Colors.black12),
//                                       )
//                                     : profilepic != null
//                                         ? Container(
//                                             height: 140,
//                                             width: 140,
//                                             decoration: BoxDecoration(
//                                               color:
//                                                   Colors.grey.withOpacity(0.3),
//                                               shape: BoxShape.circle,
//                                               image: DecorationImage(
//                                                   image: FileImage(profilepic!),
//                                                   fit: BoxFit.fitWidth),
//                                             ),
//                                           )
//                                         : InkWell(
//                                             onTap: () {
//                                               // Navigator.push(
//                                               //     context,
//                                               //     MaterialPageRoute(
//                                               //         builder: (context) =>
//                                               //             DetailScreen(
//                                               //               image: data2!.user!.photo,
//                                               //             )));
//                                             },
//                                             child: Container(
//                                               height: 140,
//                                               width: 140,
//                                               decoration: BoxDecoration(
//                                                 color: Colors.black,
//                                                 shape: BoxShape.circle,
//                                                 image: DecorationImage(
//                                                     image: NetworkImage(
//                                                         widget.userdata.image!),
//                                                     fit: BoxFit.fitWidth),
//                                               ),
//                                             ),
//                                           ),
//                                 Positioned(
//                                     bottom: 0,
//                                     right: 0,
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         profilePhoto();
//                                       },
//                                       child: Container(
//                                         height: 40,
//                                         width: 40,
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: AppColors.blue),
//                                             color: Colors.white,
//                                             shape: BoxShape.circle),
//                                         child: const Icon(
//                                           Icons.camera_alt_rounded,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ))
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 const Text("Full Name"),
//                                 TextField(
//                                   controller: fullName,
//                                   decoration: InputDecoration(),
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 const Text("Email Address"),
//                                 TextField(
//                                   controller: email,
//                                   decoration: InputDecoration(),
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 const SizedBox(
//                                   height: 25,
//                                 ),
//                                 CustomButton(
//                                   width: MediaQuery.of(context).size.width,
//                                   text: "Update",
//                                   onTap: () {
//                                     if (fullName.text.isEmpty) {
//                                       showSnack(
//                                           context: context,
//                                           text: "Please Enter FullName");
//                                     } else if (email.text.isEmpty) {
//                                       showSnack(
//                                           context: context,
//                                           text: "Please Enter Email");
//                                     } else if (!email.text.contains('@') &&
//                                         !email.text.contains('.com')) {
//                                       showSnack(
//                                           context: context,
//                                           text: "Please Enter Correct Email");
//                                     }
//                                     updateUserProfile(
//                                         context,
//                                         widget.userdata.uID!,
//                                         fullName.text,
//                                         email.text,
//                                         profilepic);
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ]),
//                   ),
//                 )),
//     );
//   }
// }
