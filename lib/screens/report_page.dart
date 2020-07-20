import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:ers/utils/global_data_utils.dart';
import 'package:flutter/material.dart';
import 'package:ers/components/export_components.dart';
import 'package:ers/provider/custom_provider.dart';
import 'package:ers/screens/home/home_page.dart';
import 'package:ers/utils/color_utils.dart';
import 'package:provider/provider.dart';
import 'package:ers/service.dart';

class ReportPage extends StatelessWidget {
  final _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        provider.setIndex = 0;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        return false;
      },
      child: Scaffold(
        key: _globalKey,
        appBar: Custom.customAppBar(context: context),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        HeaderText(
                          title: "Do you suspect COVID 19?",
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          "Report yourself, we would call you.",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        EmptySpace(multiple: 1.8),
                        FormPage(
                          globalKey: _globalKey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                height: 40.0,
                child: RaisedButton(
                  color: ColorUtils.primaryColor,
                  shape: StadiumBorder(),
                  child: Text(
                    "Chat With Authority",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => AuthServcice.goToChat(
                      context: context, globalKey: _globalKey),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}

class FormPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalKey;
  const FormPage({this.globalKey});
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _address = TextEditingController();
  final _phoneNumber = TextEditingController();

  bool noSymptoms = false;
  bool fever = false;
  bool dryCough = false;
  bool soreThroat = false;
  bool breadth = false;
  bool runningNose = false;
  bool fatiq = false;

  String localGovernment;

  @override
  void dispose() {
    _description.dispose();
    _address.dispose();
    _phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _name,
            validator: Validators.validateName(),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: "Full Name",
            ),
          ),
          EmptySpace(multiple: 2.0),
          TextFormField(
            controller: _phoneNumber,
            validator: Validators.validatePhone(),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: "Phone Number",
            ),
          ),
          EmptySpace(multiple: 2.0),
          TextFormField(
            controller: _address,
            minLines: 1,
            maxLines: null,
            validator: Validators.validateAddress(),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: "Address",
            ),
          ),
          EmptySpace(multiple: 2.0),
          DropdownButtonFormField<String>(
            value: localGovernment,
            validator: Validators.validateLocal(),
            items: GlobalDataUtils.localGovernemnts
                .map((item) => DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    ))
                .toList(),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: "Local Government",
            ),
            onChanged: (value) {
              setState(() {
                localGovernment = value;
              });
            },
          ),
          EmptySpace(multiple: 2.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.black38, width: 1.5),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Have you experienced any of the following symptoms in the last 1 week?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CheckboxListTile(
                  title: const Text('No Symptoms'),
                  value: noSymptoms,
                  onChanged: (bool value) {
                    setState(() {
                      noSymptoms = value;
                      fever = false;
                      dryCough = false;
                      runningNose = false;
                      soreThroat = false;
                      breadth = false;
                      fatiq = false;
                    });
                  },
                ),
                IgnorePointer(
                  ignoring: noSymptoms,
                  child: CheckboxListTile(
                    title: const Text('Fever'),
                    value: fever,
                    onChanged: (bool value) {
                      setState(() {
                        fever = value;
                      });
                    },
                  ),
                ),
                IgnorePointer(
                  ignoring: noSymptoms,
                  child: CheckboxListTile(
                    title: const Text('Dry Cough'),
                    value: dryCough,
                    onChanged: (bool value) {
                      setState(() {
                        dryCough = value;
                      });
                    },
                  ),
                ),
                IgnorePointer(
                  ignoring: noSymptoms,
                  child: CheckboxListTile(
                    title: const Text('Sore Throat'),
                    value: soreThroat,
                    onChanged: (bool value) {
                      setState(() {
                        soreThroat = value;
                      });
                    },
                  ),
                ),
                IgnorePointer(
                  ignoring: noSymptoms,
                  child: CheckboxListTile(
                    title: const Text('Running Nose'),
                    value: runningNose,
                    onChanged: (bool value) {
                      setState(() {
                        runningNose = value;
                      });
                    },
                  ),
                ),
                IgnorePointer(
                  ignoring: noSymptoms,
                  child: CheckboxListTile(
                    title: const Text('Difficult Breathing'),
                    value: breadth,
                    onChanged: (bool value) {
                      setState(() {
                        breadth = value;
                      });
                    },
                  ),
                ),
                IgnorePointer(
                  ignoring: noSymptoms,
                  child: CheckboxListTile(
                    title: const Text('Tiredness / Fatigue'),
                    value: fatiq,
                    onChanged: (bool value) {
                      setState(() {
                        fatiq = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          EmptySpace(multiple: 2.0),
          TextFormField(
            controller: _description,
            minLines: 3,
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: "Other Symptoms / Description",
            ),
          ),
          EmptySpace(),
          Align(
            alignment: Alignment.topRight,
            child: RaisedButton(
              color: ColorUtils.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: onSubmit,
            ),
          )
        ],
      ),
    );
  }

  List<String> handleList() {
    List<String> list = [];
    if (noSymptoms) {
      list.add('No Symptoms');
    } else {
      if (fever) list.add('Fever');
      if (dryCough) list.add('Dry Cough');
      if (soreThroat) list.add('Sore Throat');
      if (runningNose) list.add('Running Nose');
      if (breadth) list.add('Difficult Breathing');
      if (fatiq) list.add('Tiredness / Fatigue');
    }
    return list;
  }

  void onSubmit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      HelperFunction.displayProgressDialog(context);
      final report = {
        'time': Timestamp.now(),
        'name': _name.text.trim().toString(),
        "phone": _phoneNumber.text.trim().toString(),
        'address': _address.text.toString(),
        'localGovernment': localGovernment.toString(),
        'description': _description.text.toString(),
        'symptoms': handleList()
      };
      bool result = await DataConnectionChecker().hasConnection;
      if (!result) {
        HelperFunction.closeProgressDialog(context);
        HelperFunction.showSnackBar(widget.globalKey, "No Internet Connection");
        return;
      }
      Firestore.instance.collection("Reports").add(report).then(
        (result) async {
          HelperFunction.closeProgressDialog(context);
          await HelperFunction.showSuccessDialog(context: context);
          final provider =
              Provider.of<BottomNavProvider>(context, listen: false);
          provider.setIndex = 0;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
      ).catchError(
        (error) {
          HelperFunction.closeProgressDialog(context);
          HelperFunction.showSnackBar(widget.globalKey,
              "We couldn't submit your report. Please try again.");
        },
      );
    }
  }
}
