import 'dart:async';
import 'package:ers/components/custom_bottomsheets.dart';
import 'package:ers/components/custom_tags.dart';
import 'package:ers/controller/corona_data.dart';
import 'package:flutter/material.dart';
import 'package:ers/components/error_widget.dart';
import 'package:ers/components/export_components.dart';
import 'package:ers/model/report_model.dart';
import 'package:ers/provider/custom_provider.dart';
import 'package:ers/screens/home/home_page.dart';
import 'package:ers/utils/color_utils.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget {
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
        appBar: Custom.customAppBar(context: context),
        body: Column(
          children: <Widget>[
            CustomLabels(),
            EmptySpace(multiple: 1.0),
            Expanded(
              child: DisplayMap(),
            )
          ],
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}

class CustomLabels extends StatefulWidget {
  @override
  _CustomLabelsState createState() => _CustomLabelsState();
}

class _CustomLabelsState extends State<CustomLabels> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: StreamBuilder<Report>(
        stream:
            Stream.value(Provider.of<StatesProvider>(context).countryReport),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CustomErrorWidget(
              onPressed: () {
                setState(() {});
              },
            );
          }
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CustomTags(
                      label: "TOTAL CONFIRMED",
                      number: data.confirmed,
                      backgroundColor: Colors.amber,
                      textColor: Colors.black,
                    ),
                    CustomTags(
                      label: "ACTIVE CASES",
                      number: data.active,
                      backgroundColor: Colors.redAccent,
                      textColor: Colors.white,
                    ),
                  ],
                ),
                EmptySpace(multiple: 2.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CustomTags(
                      label: "TOTAL DISCHARGED",
                      number: data.discharged,
                      backgroundColor: Colors.green,
                    ),
                    CustomTags(
                      label: "TOTAL DEATHS",
                      number: data.death,
                      backgroundColor: Colors.black54,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(ColorUtils.primaryColor),
            ),
          );
        },
      ),
    );
  }
}

class DisplayMap extends StatefulWidget {
  @override
  _DisplayMapState createState() => _DisplayMapState();
}

class _DisplayMapState extends State<DisplayMap> {
  List<Report> reports;

  final Completer<GoogleMapController> _controller = Completer();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  MarkerId selectedMarker;

  @override
  void initState() {
    super.initState();
  }

  void addMarkers() {
    reports.forEach((state) {
      MarkerId markerId = MarkerId(state.state);
      markers[markerId] = Marker(
        icon: BitmapDescriptor.defaultMarker,
        markerId: markerId,
        position: LatLng(state.latitude, state.longitude),
        infoWindow: InfoWindow(title: state.state, snippet: '*'),
        onTap: () {
          CustomBottomSheets.displayData(context, state);
        },
      );
    });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return StreamBuilder<List<Report>>(
      stream: Stream.value(Provider.of<StatesProvider>(context).reports),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Our team is fixing it. Please check back",
              style: textTheme.subhead.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            reports = snapshot.data;
            addMarkers();
            return SizedBox.expand(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(9.081999, 8.675277),
                  zoom: 5.4,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: Set<Marker>.of(markers.values),
              ),
            );
          } else {
            return Center(
              child: Text(
                "No Map available",
                style: textTheme.subhead.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
        }
        return CustomProgressIndicator();
      },
    );
  }
}
