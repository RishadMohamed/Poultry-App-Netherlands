import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_login/Colors.dart';
import 'package:home_login/screens/FeedIntakeScreens/addFeed.dart';
import 'package:home_login/screens/FeedIntakeScreens/deleteFeed.dart';
import 'package:home_login/screens/FeedIntakeScreens/updateFeed.dart';
import 'package:home_login/screens/griddashboard.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../drawerMenu.dart';
import '../FeedCostScreens/feedCostView.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with TickerProviderStateMixin {
  List weightDataCobb500 = [];
  String startDate = '';
  String strainType = '';

  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  double translateX = 0.0;
  double translateY = 0.0;
  double scale = 1;
  bool toggle = false;
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Stack(
      children: [
        DrawerMenu(args.flockID),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          transform: Matrix4.translationValues(translateX, translateY, 0)
            ..scale(scale),
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: ClipRRect(
              borderRadius: (toggle)
                  ? BorderRadius.circular(20)
                  : BorderRadius.circular(0),
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.menu_arrow,
                      progress: _animationController,
                    ),
                    onPressed: () {
                      toggle = !toggle;
                      if (toggle) {
                        translateX = 200.0;
                        translateY = 80.0;
                        scale = 0.8;
                        _animationController.forward();
                      } else {
                        translateX = 0.0;
                        translateY = 0.0;
                        scale = 1;
                        _animationController.reverse();
                      }
                      setState(() {});
                    },
                    //icon: Icon(Icons.menu),
                  ),
                  title: Text("feedIntakeSelect".tr),
                  backgroundColor: mPrimaryColor,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Farmers')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('flock')
                              .where(FieldPath.documentId,
                                  isEqualTo: args.flockID)
                              .snapshots(), // your stream url,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            } else {
                              startDate = snapshot.data?.docs[0]['startdays'];
                              strainType = snapshot.data?.docs[0]['strain'];

                              updateFeedIntake(args.flockID, 0.4.toString(),
                                  50.toString(), startDate);
                            }

                            return Container(); // Your grid code.
                          }),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: Image.asset(
                          "assets/images/chickFeeding.png",
                          fit: BoxFit.fitWidth,
                          width: context.width * 0.5,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateFeedScreen(
                                  id_flock: args.flockID,
                                  startDateNavi: startDate,
                                  strainNavi: strainType,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 50),
                            backgroundColor: mPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            elevation: 20,
                            shadowColor: mSecondColor,
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text("update".tr),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            print(args.flockID);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddFeedScreen(
                                  id_flock: args.flockID,
                                  startDateNavi: startDate,
                                  strainNavi: strainType,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 50),
                            backgroundColor: mBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            side: BorderSide(color: mPrimaryColor),
                            elevation: 20,
                            shadowColor: mSecondColor,
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text(
                            "add".tr,
                            style: TextStyle(
                              color: mPrimaryColor,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DeleteFeedScreen(
                                  id_flock: args.flockID,
                                  startDateNavi: startDate,
                                  strainNavi: strainType,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 50),
                            backgroundColor: mPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            elevation: 20,
                            shadowColor: mSecondColor,
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text("Delete".tr),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            print(args.flockID);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FeedCostView(
                                  id_flock: args.flockID,
                                  startDateNavi: startDate,
                                  strainNavi: strainType,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 50),
                            backgroundColor: mBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            side: BorderSide(color: mPrimaryColor),
                            elevation: 20,
                            shadowColor: mSecondColor,
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text(
                            "FeedCost".tr,
                            style: TextStyle(
                              color: mPrimaryColor,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> updateFeedIntake(
      String id, String noOfBag, String weightBag, String date) async {
    num current = 0;
    num valueBags = double.parse(noOfBag);
    num valueBagWeight = double.parse(weightBag);

    try {
      //print("try 1");
      DocumentReference<Map<String, dynamic>> documentReference =
          FirebaseFirestore.instance
              .collection('Farmers')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('flock')
              .doc(id)
              .collection('FeedIntake')
              .doc(date);

      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await transaction.get(documentReference);

        if (!snapshot.exists) {
          //print("done 1 befre");
          documentReference.set(
              {'Number_of_bags': valueBags, 'Weight_of_a_bag': valueBagWeight});
          //print("done 1");

          //return true;
        } else {
          try {
            //num newAmount = snapshot.data()!['Amount'] + value;
            //  current = snapshot.data()!['Amount'];
            transaction.update(documentReference, {
              'Number_of_bags': valueBags,
              'Weight_of_a_bag': valueBagWeight
            });
            //print("done 1.2");
            //print(current);
            //return true;
          } catch (e) {
            //rethrow;
          }
        }
      });
      //return true;
    } catch (e) {
      // return false;
    }
    try {} catch (e) {
      //
    }
  }
}

TextFormField reusableTextField3(
    String text,
    IconData icon,
    bool isPasswordType,
    TextEditingController controller,
    validator,
    bool val) {
  return TextFormField(
    onTap: () {
      print("shamod");
    },
    enabled: val,
    controller: controller,
    validator: validator,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.brown,
    style: TextStyle(color: Colors.black38),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: mPrimaryColor,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.black38),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      fillColor: Colors.grey[50],
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            width: 2,
            color: mPrimaryColor,
          )),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: mPrimaryColor,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: mPrimaryColor,
          width: 2.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(
          color: mPrimaryColor,
          width: 2.0,
        ),
      ),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}
