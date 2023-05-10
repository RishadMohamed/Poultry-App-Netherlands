import 'package:flutter/material.dart';
import 'package:home_login/Colors.dart';
import 'package:home_login/net/flutter_fire.dart';
import 'package:home_login/screens/reusable.dart';
import 'package:home_login/screens/UserRegScreens/signup_screen.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FlockRegScreen extends StatefulWidget {
  late String shedID, branchID, farmID;
  FlockRegScreen(this.shedID, this.branchID, this.farmID);
  //const BrachRegScreen({Key? key}) : super(key: key);

  @override
  State<FlockRegScreen> createState() =>
      _FlockRegScreenState(shedID, branchID, farmID);
}

class _FlockRegScreenState extends State<FlockRegScreen> {
  List<String> items = [
    'Cobb 500 - Broiler',
    'Ross 308 - Broiler',
    'Dekalb White - Layer',
    'Shaver Brown - Layer'
  ];
  String? selectedItem;
  DateTime sdate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime bdate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  //GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //late String _username,_password;
  late String shedID, branchID, farmID;
  _FlockRegScreenState(this.shedID, this.branchID, this.farmID);

  //final TextEditingController _locationController = TextEditingController();
  final TextEditingController _branchNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _strainController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        //key: formKey,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20,
                  MediaQuery.of(context).size.height * 0.1,
                  20,
                  MediaQuery.of(context).size.height * 0.1),
              child: Column(
                children: <Widget>[
                  Text(
                    "Add Flock".tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: mPrimaryColor),
                  ),
                  const SizedBox(height: 40),
                  Image.asset(
                    "assets/icons/shedNew.jpg",
                    fit: BoxFit.fitWidth,
                    width: 300,
                    height: 300,
                    //color: Colors.purple,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  reusableTextField("Enter Flock Name".tr, Icons.house, false,
                      _branchNameController, null),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField2("Enter the number of chickens".tr,
                      Icons.numbers, false, _numberController, null, ""),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.egg,
                          color: mPrimaryColor,
                        ),
                        labelText: 'Select The Strain',
                        labelStyle:
                            TextStyle(color: Colors.black38, fontSize: 2.5.h),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.h),
                            borderSide: BorderSide(
                              width: 2,
                              color: mPrimaryColor,
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.h),
                          borderSide:
                              BorderSide(width: 2.0, color: mPrimaryColor),
                        )),
                    value: selectedItem,
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item,
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 2.5.h)),
                            ))
                        .toList(),
                    onChanged: (item) => setState(() => selectedItem = item),
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 15.0),
                          child: reusableTextField3(
                              sdate.toString().substring(0, 10),
                              Icons.date_range,
                              false,
                              _startDateController,
                              null,
                              false),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 15.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              DateTime? ndate = await showDatePicker(
                                context: context,
                                initialDate: sdate,
                                firstDate: DateTime(2022),
                                lastDate: DateTime.now(),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: mNewColor,
                                        onPrimary: Colors.white, // <-- SEE HERE
                                        onSurface: mSecondColor, // <-- SEE HERE
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          primary:
                                              mPrimaryColor, // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (ndate == null) return;
                              setState(() => sdate = ndate);
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(180, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(
                                    width: 2.0,
                                    color: mPrimaryColor,
                                  )),
                              primary: mBackgroundColor,
                              elevation: 20,
                              shadowColor: Colors.transparent,
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: Text(
                              "Set The Start Date".tr,
                              style: TextStyle(color: Colors.black38),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 15.0),
                          child: reusableTextField3(
                              bdate.toString().substring(0, 10),
                              Icons.date_range,
                              false,
                              _birthDateController,
                              null,
                              false),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 15.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              DateTime? ndate = await showDatePicker(
                                context: context,
                                initialDate: bdate,
                                firstDate: DateTime(2022),
                                lastDate: DateTime.now(),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: mNewColor,
                                        onPrimary: Colors.white, // <-- SEE HERE
                                        onSurface: mSecondColor, // <-- SEE HERE
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor:
                                              mPrimaryColor, // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (ndate == null) return;
                              setState(() => bdate = ndate);
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(180, 50),
                              backgroundColor: mBackgroundColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(
                                    width: 2.0,
                                    color: mPrimaryColor,
                                  )),
                              elevation: 20,
                              shadowColor: Colors.transparent,
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: Text(
                              "Set The Birth Date".tr,
                              style: TextStyle(color: Colors.black38),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      onPressed: () async {
                        await addFlock(
                            _branchNameController.text,
                            shedID,
                            branchID,
                            farmID,
                            sdate.toString().substring(0, 10),
                            selectedItem.toString(),
                            _numberController.text,
                            bdate.toString().substring(0, 10));
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Submit".tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.white;
                            }
                            return mPrimaryColor;
                          }),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30)))),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 300,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
